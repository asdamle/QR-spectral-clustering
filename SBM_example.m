% example of spectral clustering for the stochastic block model (SBM)

%% parameter set up

% set number of clusters
m = 150;   % nodes per cluster
k = 7;     % number of clusters
p = .7;    % in cluster connection probability
q = .3;    % out of cluster connection probability
n = m*k;

%% build SBM matrix, including true clustering
A = tril(rand(n) < q);
truth = [];
for j = 1:k;
idx = (j-1)*m+1:j*m;
A(idx,idx) = tril(rand(m) < p);
truth = [truth j*ones(1,m)];
end
A = A + A';


%% perform clustering with degree normalization
[X] = spectral_cluster(A,k,1);

%% should match up to a labeling
plot([X truth'])