function [mle] = comp_mle(A,idx)

% compute cuts between each cluster in idx and the rest of the graph
% A is the graph and idx must label clusters 1,2,...,k

k = max(idx);

d = zeros(k,1);
for i = 1:k    
    d(i) = sum(sum(A(idx==i,idx==i)));
end
mle = sum(d);