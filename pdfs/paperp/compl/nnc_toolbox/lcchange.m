function [corrPw nullDist] = lcchange(expression, experiment,pTime,nstep, opt)

% change of local correlation and change of Pearson correlation
% between genes and between two different experimental conditions.
% SYNTAX: [corrPw nullDist] = lcchange(expression, experiment,pTime,nstep)
% 
% INPUTS: (using gene expression data as an example here)
%   
%   expression: a cell contains 2 N-by-q matrix, N: number of
%           genes, and q number of time points or measurements.
%   expiriment: the labels for experiment.
%   pTime: Permutation replications, a scalar.
%   nstep: grid size
%   opt: opt=1 - ranked scale, opt=2 - raw scale
%
% OUTPUTS:
%
%   corrPw: a structure variable containing delta stastistics (deltaC, 
%               deltaM, and deltaT, and thier associated p-values.
%
% REFERENCE:
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression, published in the Journal of Computational and Gradphical
% Statistics

% Y. Ann Chen, Moffitt Cancer Center, ann.chen@moffitt.org

nCon = length(expression);
N = size(expression{1},1);
nComp = N*(N-1)/2;


if nCon~=2
    error('Currently, this method only applies to 2 experimental conditions.')
end

if nargin<2
    experiment{1} = 'Control';
    experiment{2} = 'Experimental';
elseif nargin <3
    pTime = 24;
elseif nargin<4
    nstep=N;
elseif nargin<5
    opt=1; % ranked
end

pwCI = cell(1,nCon);
nullDist = cell(1,nCon);
nSim = nComp*pTime;
distMetric= zeros(N,N,nCon);
corrPw.M = zeros(nComp, nCon);

for i = 1:nCon  % 2 is current setting, control vs. exp
    
    distMetric(:,:,i) = squareform(pdist(expression{i})); % distance matrix
    pwCI{i} = corr_integral_pw(distMetric(:,:,i),nstep,opt); 
    
    % D* and PearsonStar (or CStar)
    nullDist{i} = nullpw(expression{i},pTime,nstep,opt); 
    
    % get Do, l 
    corrPw.Do(i,:) = median(nullDist{i}.dI);
    corrPw.l(:,:,i) = pwCI{i}.dI-repmat(corrPw.Do(i,:),nComp,1); 
    
    %M (Maximum Local correlation)
    corrPw.absl(:,:,i) = abs(corrPw.l(:,:,i));
    corrPw.M(:,i) = max(corrPw.absl(:,:,i),[],2); 
    corrPw.C(:,i) = pwCI{i}.PearsonRho';
    
    % M* for the null distribution
    nullDist{i}.abslStar = abs(nullDist{i}.dI - repmat(corrPw.Do(i,:), nSim,1));
    nullDist{i}.MStar = max(nullDist{i}.abslStar,[],2); 
    
    
end

% calculate delta statistics between two conditions
corrPw.deltaM = corrPw.M(:,1)-corrPw.M(:,2);
corrPw.deltaC = (pwCI{1}.PearsonRho - pwCI{2}.PearsonRho)';

% null ditribution for the delta statistics 

corrPw.deltaMStar = nullDist{1}.MStar - nullDist{2}.MStar;
corrPw.deltaCStar = nullDist{1}.Pearson - nullDist{2}.Pearson;

% pvalues for the delta statistics
corrPw.pOfdeltaM = corrprob3(corrPw.deltaM, corrPw.deltaMStar', 1, 2);
corrPw.pOfdeltaC = corrprob3(corrPw.deltaC, corrPw.deltaCStar', 1, 2);
clear pwCI 

