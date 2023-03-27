function corrOut = lc(X,Y,nSim,opt,nstep,optNull)

% main function calculates bivariate local correlation
% SYNTAX corrOut = lc(X,Y,nSim,opt,nstep,optNull)
% 
% INPUTS: 
%   X,  a N-by-nType matrix, and nType is the number of (X,Y) pairs.
%   Y,  the same dimension as X
%   nSim, number of simulations, a scalar, an optional input. 
%         The default value is 4000.
%   opt: default, opt=1, ranked scales; opt=2, raw value
%   nstep: grid size
%   optNull: option to save the null distribution
%
% OUTPUTS: 
% corrOut, a structure variable with fields for local correlation (l),  
%           maximum correlation (M), Pearson Correlation (C), 
%           Spearman correlation (S), 
%           and the associated estimated probabilities.
%
% REFERENCE:
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression, published in the Journal of Computational and Gradphical
% Statistics
%
% Y. Ann Chen, Moffitt Cancer Center, ann.chen@moffitt.org

% check dimension
N = size(Y,1);
nType = size(Y,2);

if (nType~=size(X,2))
    error('Number of cases for X and Y has to be the same.')
elseif (N~=size(X,1))
    error('Sample size for X and Y has be the same.')
end

if nargin < 2
     error('At least two input variables, X and Y, are reuired.')
elseif nargin <3
    nSim = 4000; opt = 1;  nstep = N; 
elseif nargin <4
    opt = 1;  % default is 1, rank scale
    nstep = N;
elseif nargin <5
    nstep = N;  % default grid size
end  


% initialization
rMemb2 = cell(1,nType);
lcNull = cell(1,nType);
corrOut.Do = zeros(nType, nstep);    % null dist
corrOut.l = zeros(nType, nstep);     % l
corrOut.pl = zeros(nType, nstep);    %p(l)
corrOut.TStar =zeros(nType,nSim);
corrOut.MStar =zeros(nType,nSim);
corrOut.C = zeros(nType,1);
corrOut.S = zeros(nType,1);
corrOut.T = zeros(nType,1);
corrOut.M = zeros(nType,1);


% calculate I and D (Eqs 1 & 2)
for i = 1:nType
    rMemb2{i} = corr_integrallocal(X(:,i), Y(:,i),opt, nstep);
end
corrOut.grid =rMemb2{1}.Int.d(2:end);


if exist('optNull','var')

% null distribution of D and Do
    [ND,pearsonStar, spearmanStar] = nullforsim(X, Y, nSim,opt,nstep,optNull);
else
    [ND,pearsonStar, spearmanStar] = nullforsim(X, Y, nSim,opt,nstep);
end


for i = 1:nType
    
    corrOut.Do(i,:) = median(ND{i}); % Do
    
    % calculate l & p(l)(Eqs 3 & 4)
    corrOut.l(i,:) = rMemb2{i}.Int.dI - corrOut.Do(i,:); 
    lcNull{i} = ND{i} - repmat(corrOut.Do(i,:), nSim,1);   
    corrOut.pl(i,:) = local_prob5(corrOut.l(i,:), lcNull{i});    
    
    % eqs 9
    corrOut.C(i,1) = corr(X(:,i), Y(:,i));
    corrOut.S(i,1) = corr(X(:,i), Y(:,i), 'type', 'Spearman');
    
    % the null distribution (T* & M*) 
    corrOut.TStar(i,:) = sum((abs(ND{i} -repmat(corrOut.Do(i,:), nSim,1))*1/nstep),2)'; 
    corrOut.MStar(i,:) = max(abs(ND{i} -repmat(corrOut.Do(i,:), nSim,1)),[],2)'; 
    
end


% T & M
corrOut.absl = abs(corrOut.l);
corrOut.T = sum(corrOut.absl*1/nstep,2); 
corrOut.M = max(corrOut.absl,[],2); 

%P(T) & p(M)
corrOut.pT = corrprob3(corrOut.T, corrOut.TStar, 0, 1); % one-sided test 
corrOut.pM = corrprob3(corrOut.M, corrOut.MStar, 0, 1); % one-sided test 

% Eq 10
corrOut.pC = corrprob3(corrOut.C, pearsonStar, 0, 2); % two-sided
corrOut.pS = corrprob3(corrOut.S, spearmanStar, 0, 2); % two-sided

