function  pOut = corrprob3(corrInput, Nullpearson, opt, side)

% Estimate acheived significance for Pearson, Spearman, maximum or total 
%   local correlation using a null distribution
% SYNTAX: pOut = corrprob3(corrInput, Nullpearson, opt, side)
% 
% INPUTS:
%       corrInput: an ntype-by-1 matrix of observed correlation (e.g., 
%                   pearson correlation, spearman correlation, total local 
%                   correlation, etc)
%
%       Nullpearson: null distrituion(s),  a ntype-by-nSim matrix
%              
%       opt: opt = 1, one null distribution for all cases, and 
%            opt = 0, one null distribution for each case.
%
%       side: one side test or two-sided test, details see the reference
%             below, default is two-sided test.
% OUTPUTS:
%       pOut: estimated acheived significance for the statistics.
% 
% REFERENCE:
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression, published in the Journal of Computational and Gradphical
% Statistics
%
% Y. Ann Chen, Moffitt Cancer Center, ann.chen@moffitt.org

if nargin < 3
    opt = 0;
    side = 2; % default is two-sided test
elseif nargin < 4
    side =2;
end

ntype = size(corrInput,1);
nSim = size(Nullpearson,2);
pOut=zeros(1,ntype);

switch opt
    case 0
        % ntype null distributions correspond to ntype observed data
        for i = 1:ntype
            if side ~=2
                pOut(i) = sum(corrInput(i)<Nullpearson(i,:))/nSim;
            else
                pOut(i) = sum(abs(corrInput(i))<abs(Nullpearson(i,:)))/nSim;
            end
        end
    case 1
        % only one null distribution for all n-types (or n-cases)
        for i = 1:ntype
            if side ~=2
                pOut(i) = sum(corrInput(i)<Nullpearson)/nSim; % one-side p-value
            else 
                pOut(i) = sum(abs(corrInput(i))<abs(Nullpearson))/nSim; % two-sided p-value
            end
        end
end