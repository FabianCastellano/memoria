%% An example to demo how to use the nnc toolbox to estimate
% correlation change (the delta statistics) in the paper.
% Some parameters used in the paper are listed in the comments below.
%
%% REFERENCE:
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression, published in the Journal of Computational and Gradphical
% Statistics
%
% Y. Ann Chen, Moffitt Cancer Center, ann.chen@moffitt.org

% Before you try to run the script, modify the following as needed: 
% 1. addpath proper path for the toolbox and data folders
% 2. loading the matfile
% Runtime depends on pTime and nstep, e.g., nstep=N could run overnight.

clear
addpath ../nnc_toolbox
addpath ../data_related

tic
load expression181dataset.mat
pTime = 2; % pTime=24 is used in the paper
N = size(expression{1},1); 
nstep= 20; % nstep=N is used in the paper
corrPw  = lcchange(expression, experiment,pTime,nstep,1);
toc


