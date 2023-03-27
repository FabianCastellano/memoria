function nullDist = nullpw(expressioni,pTime,nstep,opt)

% null distriution simultation using permutation  
% SYNTAX: nullDist = nullpw(expressioni,pTime,nstep)
%
% INPUTS:
%       expressioni: a N-by-q matrix, N is the number of genes, and q is 
%                   the number of time points.
%       pTime: a scalar, number of independent of times of permutation for
%               all pair-wise comparisons.  This should be a rather small
%               number because all possible pair of comparisons is already
%               large.
%       nstep: grid size
% OUTPUTS:
%       nullDist, the simulated null distribution
%
% see also lcchange
%
% REFERENCE:
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression, published in the Journal of Computational and Gradphical
% Statistics

% Y. Ann Chen, Moffitt Cancer Center, ann.chen@moffitt.org



if nargin <2
    pTime = 24; % default
end

%rand('state', sum(100*clock));

N = size(expressioni,1);
numOfGene = size(expressioni,1);
nComp =numOfGene*(numOfGene-1)/2;
nSim = nComp*pTime;
nullDist.dI = zeros(nSim,nstep);
nullDist.Pearson = zeros(nSim,1);

for b =1:pTime
    
    q = size(expressioni,2);
    
    for i = 1:q
        permExpC(:,i) = expressioni(randperm(numOfGene),i);
    end
    
    % calculate distance matrix
    pdist181C = squareform(pdist(permExpC)); % control

    % pair-wise correlation of two columns in distance matrix
    pwPermC = corr_integral_pw(pdist181C,nstep,opt);
    nullDist.dI((b-1)*nComp+1:b*nComp,:) = pwPermC.dI;
    nullDist.Pearson((b-1)*nComp+1:b*nComp,1) = pwPermC.PearsonRho';
    clear pwPermC
    disp(b);
end

