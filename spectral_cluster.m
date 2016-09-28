function [X] = spectral_cluster(A,k,normalize)

% input:
%
%    A:          N x N adjacency matrix of a simple undirected graph, can
%                be sparse or dense
%    k:          The number of clusters desired
%    normalize:  If 0 A is used directly, otherwise degree normalization is
%                applied
%
% output:
%
%    X: a N x 1 vector where each node is assigned to a cluster, clusters
%       are encoded as the integers from 1 to k


% eigs is used assuming A is large and sparse in general
N = size(A,1);
if issparse(A)
    if normalize
        D = spdiags(1./sqrt(sum(A)'),0,N,N);
        A = D*A*D;
    end
    [V , ~] = eigs(A,k);
else
    if normalize
        D = diag(1./sqrt(sum(A)));
        A = D*A*D;
    end
    [V, ~] = eig(A);
    V = V(:,end-k+1:end);
end
V = clusterQR_random(V,4);
[~, X] = max(abs(V),[],2);

