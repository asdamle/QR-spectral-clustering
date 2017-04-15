function [correct] = verify_true(compute,truth)

correct = 1;
for k = 1:max(truth);
    idx = find(truth == k,1);
    if length(find(compute == compute(idx))) ~= length(find(truth == k))
        correct = 0;
    elseif find(compute == compute(idx)) ~= find(truth == k)
        correct = 0;
    end
end
    




