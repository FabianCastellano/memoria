function pwCI = corr_integral_pw(distMetric,nstep,opt)

% All against all pair-wise local correlation integral calculation and 
%   Pearson Correlation. 
% SYNTAX: pwCI = corr_integral_pw(distMetric,nstep)
%
% INPUT: 
%       distMetric: a square distance metric 
%       nstep: grid size
%       opt: opt=1 - ranked scale, opt=2 - raw scale
% OUTPUT: 
%       pwCI, a structure variable has  all pair-wise comparison of 
%           neighbor densities and Pearson Correlation
%
% REFERENCE:
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression, published in the Journal of Computational and Gradphical
% Statistics

% Y. Ann Chen, Moffitt Cancer Center, ann.chen@moffitt.org

numOfGene = size(distMetric,1);

if numOfGene~= size(distMetric,2)
    warning('Input is not a square distance matrix');
end

nComps = numOfGene*(numOfGene-1)/2; % num of comparisons
pwCI.dI = zeros(nComps, nstep); % D
pwCI.PearsonRho = zeros(1, nComps); % C

count = 0;
for i = 1:numOfGene-1
    for j = (i+1): numOfGene
        count = count+ 1; 
         % Pearson Corr
        pwCI.PearsonRho(count)= corr(distMetric(:,i), distMetric(:,j));
        
        % calculate ND
        r_pw = corr_integrallocal(distMetric(:,i), distMetric(:,j),opt,nstep);
        pwCI.dI(count,:) = r_pw.Int.dI;
            
    end
end
