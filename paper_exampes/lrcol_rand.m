function [U, piv] = lrcol_rand(U,r,ortho,gamma)

% U is N x k
% use the first r columns, i.e. get r localized basis vectors
% ortho = 1 yields an orthogonal basis, 0 is just columns of UU^T
% gamma is the oversampling factor

NN = size(U,1);
count = min(ceil(gamma*r*log(r)),NN);
rho = sum(U'.^2);
rho = rho/sum(rho);
rhosum = cumsum(rho);

[~, I] = histc(rand(1,count),[0 rhosum]);
I = unique(I);


[Q, ~, idx] = qr(U(I,:)',0);
idx = idx(1:r);
piv = I(idx);
if ortho
    [Ut, ~, Vt] = svd(U(piv,:)',0);
    U = U*(Ut*Vt');
%     U = U*Q;
else    
    U = U*(U(piv,:)');
end