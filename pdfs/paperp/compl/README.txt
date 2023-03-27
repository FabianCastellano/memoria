%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% There are 4 folders in the supplemental materials: 
%	
%	A. data-related: data or scripts used to simulate the data.
%
%	B. nnc_toolbox: the Matlab functions for estimating nonparametric 
%		nonlinear correlation
%
%	C. scripts: demonstration Matlab scripts to call functions in nnc_toolbox
%
%	D. Appendix: Appendices A-E referred in the paper
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% A. data-related:
%
% 1. Dataset_1_for_mat.txt: the dataset (from Jonnalagadda and Srinivasan, 
%    2004) used to generated Cases 10, 11, and 12.
% 2. generate12SimCases.m: the Matlab script used to simulate the 12 cases.
% 3. sim2.m: a Matlab function, called by generate12SimCases.m,
%    and used for simulation of the 12 cases.
% 4. trasform.m: a Matlab function, called by generate12SimCases.m,
%    and used for simulation of the 12 cases.
% 5. forPositiveRates.m: the Matlab script used to generate the 100 realizations 
%    for each of the cases with stochastic components (i.e., Cases 1, 
%    and 8 to 12).  The simulated data were used to
%    estimate positive rates of testing for significant 
%    maximum local correlation M. If one would like to generate identical 
%    datasets, seedforPR.mat contains the seed used in the simulation.
% 6. seedforPR.mat: the seed used to generate 100 realizations 
%    for each of the cases with stochastic components. 
% 7. twelveCases.mat: the datafile (in Matlab format)contains 12 simulated cases,
%    the results of local correlation are shown in Figure 4 in the manuscript.
%    simX is 100-by-12 and simY is 100-by-12. They correspond to X and Y of 
%    the 12 simulated cases.
% 8. sim12Cases.mat: the datafile(in Matlab format)contains 12 simulated cases, 
%	used in some of the demo m-files. 
% 9. expression181dataset.mat: microarray expression data used in the study.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% B. nnc_toolbox: to estimate Maximum local correlation and delta statistics. 
%	Two main functions are: lc.m and lcchange.m.  Other functions called
%	by these two functions are also included.
% 
% 1. lc.m: The main function to estimate Maximum local correlation
% 
% 2. lcchange.m & sigac.m: The main functions to estimate 
%       deltaM, and deltaC and identify critical genes with significant 
%       association change. It takes longer pertiod time to run, so running
%       it as a back ground job is generally desirable
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% C. scripts: demonstration Matlab scripts to call functions in nnc_toolbox
% 	
% 1. demo_script_mlc.m: a Matlab script to demonstrate how to estimate Maximum 
% 	local correlation, M.
% 2. demo_script_lcchange.m: a Matlab script to demonstrate how to estimate 
% 	correlation change, the delta statistics described in the paper.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% D. Appendix: Appendices A-E referred in the paper
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REFERENCE:
%
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression, published in the Journal of Computational and Graphical
% Statistics
%
% Y. Ann Chen, Moffitt Cancer Center, ann.chen@moffitt.org