function listOfAC = sigac(corrPw, N, geneAnnotation,pcutoff, fileoutfolder)

% list the genes with significant linear and nonlinear association change, 
% and write the output into a file
% SYNTAX: listOfAC = sigac(corrPw, N, geneAnnotation,pcutoff,
% fileoutfolder)
%
% INPUTS: (using gene expression data as an example here)
%   
%   corrPw: structure variable containing containing delta stastistics (deltaC, 
%               deltaM, and deltaT, and thier associated p-values. This is
%               the output from functionlcchange.
%
%   N: number of genes, a scalar.
%
%   geneAnnotation: annotation for genes, two columns, first column is the
%               probe ID, and second column is the gene symbol
%   pcutoff: a 1-by-2 or 2-by-1 vector, the cut off values for p-values for 
%            delta statistics. the default values were the ones used in the 
%            references listed below, but not recommended used for every 
%            dataset.  Each dataset should have different cut-off when FDR
%            is controled at the same level, i.e., it is data-dependent.
%
%   fileoutfolder: the folder to write the output files.
% 
% OUTPUTS:
%
%   listOfAC: a 1-by-3 cell containing three lists of genes with significant
%               association change.  
%               
%               1st, results of deltaM 
%               2nd one, results of deltaC
% 
% also see lcchange.
%
%% REFERENCE:
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression, published in the Journal of Computational and Gradphical
% Statistics
%
% Y. Ann Chen, Moffitt Cancer Center, ann.chen@moffitt.org

nStat = 2; 
pvalSq2=zeros(N,N,nStat);

if nargin < 4
    fileoutfolder=''; % current directory
    pcutoff(1) =10e-3;
    pcutoff(2) =10e-3;
elseif nargin <5
    fileoutfolder=''; % current directory
end


pvalSq2(:,:,1) = squareform(corrPw.pOfdeltaM);
pvalSq2(:,:,2) = squareform(corrPw.pOfdeltaC);
fileoutname{1}= [fileoutfolder 'sigM.txt'];
fileoutname{2}= [fileoutfolder 'sigC.txt'];

% resume here to modify it from fileout to folderout.
for i = 1:nStat
    listOfAC{i} = associationchange2(pvalSq2(:,:,i), pcutoff(i), N, geneAnnotation, fileoutname{i});
    listOfAC{i}.list_txt = geneAnnotation(listOfAC{i}.list,2);
end

