function [U, piv] = clusterQR(U)

% U is N x k and columns are the eigenvectors to be used
%
% U returns the cluster assignment vectors, generically,
% clustering is done by taking location of the max absolute entry in each
% row as the cluster assignment.
%
% piv encodes which columns of UU^T were picked by the QRCP

k = size(U,2);
[Q, ~, piv] = qr(U',0);
piv = piv(1:k);
U = U*Q;