function [d] = comp_dist(V,idx,C)

% compute sum of squared distances for rows of V based on clustering idx
% is C is empty compute the cluster centers, else use rows of C
k = size(V,2);
if isempty(C)
    for i = 1:k
        C(i,:) = sum(V(idx==i,:))/sum(idx==i);
    end
end
d = zeros(k,1);
for i = 1:k
    d(i) = sum(pdist2(V(idx==i,:),C(i,:)).^2);
end