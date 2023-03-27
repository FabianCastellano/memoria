%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% README FILE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 1. lc.m: The main function to estimate Maximum local correlation
% 
% 2. lcchange.m & sigac.m: The main functions to estimate 
%       deltaM, and deltaC and identify critical genes with significant 
%       association change. It takes longer pertiod time to run, so running
%       it as a background job is generally desirable
%
% 3. relavant Data files: expression181dataset.mat and sim12Cases.mat.
%
% 4. demo_script_mlc.m: a Matlab script to demonstrate how to estimate 
%   Maximum local correlation, M.
%
% 5. demo_script_lcchange.m: a Matlab script to demonstrate how to estimate 
% 	correlation change, the delta statistics described in the paper.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% REFERENCE:
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression, published in the Journal of Computational and Gradphical
% Statistics
%
% Y. Ann Chen, Moffitt Cancer Center, ann.chen@moffitt.org