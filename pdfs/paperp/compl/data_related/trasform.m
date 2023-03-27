function out = trasform(original, newMin, newMax)
% used for simulation of Case 11
% linearly transform original values to new values based on input min and max

oldMin = min(original);
oldMax = max(original);
n = length(original);
out = newMin +(newMax-newMin)*(original - repmat(oldMin, n,1))./(oldMax-oldMin);
