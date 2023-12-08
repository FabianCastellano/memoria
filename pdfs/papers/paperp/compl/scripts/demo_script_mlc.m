%% A quick example to demo how to use the nnc toolbox to estimate
% Maximum local correlation (M) between two vectors for 12 simulated cases

%% Step 0. add path to the toolbox, 
% i.e., change the path to where you saved the toolbox and datasets

clear
addpath ../nnc_toolbox
addpath ../data_related

% load data
load sim12Cases.mat


%% step 1. Estimation of T, C, S between X and Y

%% 1-1.Estimate M, C, S between X and Y
% nSim: number of simulations, suggested nSim is generally at least 
% in the thousands (e.g. 4000, here n = 20 for a quick demo)

nSim = 20; % nSim=4000 in the paper
plt = 0;
corrOut = lc(simX,simY,nSim);

%% 1-2. plot the relationships between X and Y

figure; scatterxy(simX, simY) % default opt is 1, i.e., original scale
figure;scatterxy(simX, simY,2) % ranked scale

%% 1-3. plot the result of local correlation
plotlc(corrOut, 1)  

%% 1-4. summarize the results of M, C, S and the estimated p-values.

% Correlation coefficients: C, S, M 
[corrOut.C corrOut.S  corrOut.M]

% Estimated probabilities p(C), p(S), and p(M) 
[corrOut.pC' corrOut.pS' corrOut.pM']

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% REFERENCE:
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression, published in the Journal of Computational and Gradphical
% Statistics
%
% Y. Ann Chen, Moffitt Cancer Center, ann.chen@moffitt.org
