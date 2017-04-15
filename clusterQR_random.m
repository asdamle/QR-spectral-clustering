function [U, piv] = clusterQR_random(U,gamma)

% U is N x k and columns are the eigenvectors to be used
%
% U returns the cluster assignment vectors, generically,
% clustering is done by taking location of the max absolute entry in each
% row as the cluster assignment.
%
% piv encodes which columns of UU^T were picked by the QRCP
%
% gamma is the oversampling factor, i.e. gamma*k*log(k) columns are used

k = size(U,2);
NN = size(U,1);
count = min(ceil(gamma*k*log(k)),NN);
rho = sum(U'.^2);
rho = rho/sum(rho);
rhosum = cumsum(rho);

[~, I] = histc(rand(1,count),[0 rhosum]);
I = unique(I);


[~, ~, idx] = qr(U(I,:)',0);
idx = idx(1:k);
piv = I(idx);
[Ut, ~, Vt] = svd(U(piv,:)',0);
U = U*(Ut*Vt');