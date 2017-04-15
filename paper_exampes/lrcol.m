function [U, piv] = lrcol(U,r,ortho)

% U is N x k
% use the first r columns, i.e. get r localized basis vectors
% ortho = 1 yields an orthogonal basis, 0 is just columns of UU^T

[Q, ~, piv] = qr(U',0);
piv = piv(1:r);
if ortho
    [Ut, ~, Vt] = svd(U(piv,:)',0);
    U = U*(Ut*Vt');
%     U = U*Q;
else    
    U = U*(U(piv,:)');
end