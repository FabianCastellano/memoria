/data_related/readme.txt

1. readme.txt: describes each of the data-related files 
2. Dataset_1_for_mat.txt: the dataset (from Jonnalagadda and Srinivasan, 
    2004) used to generated Cases 10, 11, and 12.
3. generate12SimCases.m: the Matlab script used to simulate the 12 cases.
4. sim2.m: a Matlab function, called by generate12SimCases.m,
    and used for simulation of the 12 cases.
5. trasform.m: a Matlab function, called by generate12SimCases.m,
    and used for simulation of the 12 cases.
6. forPositiveRates.m: the Matlab script used to generate the 100 realizations 
    for each of the cases with stochastic components (i.e., Cases 1, 
    and 8 to 12).  The simulated data were used to
    estimate positive rates of testing for significant 
    maximum local correlation M. If one would like to generate identical 
    datasets, seedforPR.mat contains the seed used in the simulation.
7. seedforPR.mat: the seed used to generate 100 realizations 
    for each of the cases with stochastic components. 
8. twelveCases.mat: the datafile (in Matlab format)contains 12 simulated cases,
    the results of local correlation are shown in Figure 4 in the manuscript.
    simX is 100-by-12 and simY is 100-by-12. They correspond to X and Y of 
    the 12 simulated cases.
9. sim12Cases.mat: the datafile(in Matlab format)contains 12 simulated cases, 
	used in some of the demo m-files. 
10. expression181dataset.mat: microarray expression data used in the study.


%% REFERENCE:
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression, published in the Journal of Computational and Gradphical
% Statistics
