function [ND,pearson, spearman] = nullforsim(X, Y, nSim, opt, nstep,optNull)

% permutation to generate null distributions
% SYNTAX: [ND,pearson, spearman] = nullforsim(X, Y, nSim, opt, nstep)
% 
% INPUTS: 
%       X: a N-by-nType matrix
%       Y: a N-by-nType matrix
%       nSim: number of simulation replications, a scalar.
%       nstep: grid size
%       opt: default, opt=1, ranked scales; opt=2, raw value
%       optNull: option to save the null distribution
%
% OUTPUTS: the null distribution of ND, pearson and spearman 
%           default grid size m is N, number of observations
% 
% also see lc
%
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression, published in the Journal of Computational and Gradphical
% Statistics

% Y. Ann Chen, Moffitt Cancer Center, ann.chen@moffitt.org

N = size(Y,1);
if nargin<5
    nstep = N; % default grid size
end


nType = size(Y,2);
ND = cell(1,12);
pearson = zeros(nType,nSim); 
spearman = zeros(nType,nSim); 

if exist('optNull','var') % save the null distribution
    XStarAll=zeros(N,nSim,nType);
    YStarAll=zeros(N,nSim,nType);
    
    for i =1:nType
         ND{i} = zeros(nSim,nstep);
        % permutation  
        for j = 1:nSim
            Xstar = X(randperm(N),i);
            Ystar = Y(randperm(N),i);
            r = corr_integrallocal(Xstar,Ystar, opt, nstep);
            ND{i}(j,:) = r.Int.dI;
            pearson(i,j) = corr(Xstar,Ystar);
            spearman(i,j) = corr(Xstar,Ystar,'type', 'Spearman');
            XStarAll(:,j,i)=Xstar; % the way it is read, only 1 nType at a time.
            YStarAll(:,j,i)=Ystar;
        end
        disp(i);
    end
    eval(['save (''' optNull.path optNull.header  '''' , ',',  '''XStarAll''',  ',' '''-ascii''' ')' ]);
    eval(['save (''' optNull.path optNull.header  '''' , ',',  '''YStarAll''',  ',' '''-ascii''' ')' ]);
    clear XStarAll YStarAll
else % not save the null distribution
    for i =1:nType
         ND{i} = zeros(nSim,nstep);
        % permutation  
        for j = 1:nSim
            Xstar = X(randperm(N),i);
            Ystar = Y(randperm(N),i);
            r = corr_integrallocal(Xstar,Ystar, opt, nstep);
            ND{i}(j,:) = r.Int.dI; 
            pearson(i,j) = corr(Xstar,Ystar);
            spearman(i,j) = corr(Xstar,Ystar,'type', 'Spearman');
        end
        disp(i);
    end
end
