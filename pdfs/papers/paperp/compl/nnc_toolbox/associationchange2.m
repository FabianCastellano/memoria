
function listOfAC = associationchange2(observedp, pcutoff, numOfGene, txtAnnotation181, fileout)

% List and rank all the genes with significant assocaition changes, 
%   and write the output into a file
% SYNTAX: listOfAC = associationchange2(observedp, pcutoff, N, geneAnnotation,
% fileoutname)
%
% INPUTS: 
%   observedp:  a square matrix of probability for pair-wise statistics.
%   pcutoff: a scalar, the cutoff value for estimated p-value for the delta 
%             statistic.  For instance, it can be estimated using
%               Q-value software when controlling at certain FDR. 
%   N : number of genes            
%   txtAnnotation181: annotation for genes, a N-by-2 cell, first column is the
%               probe ID, and the second column contains the gene symbol
%   fileout: output file name
%
% OUTPUTS: 
%   listOfAC: a list of ranked genes with significant association change
%
% see also lcchange, sigac
%
% REFERENCE:
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression, published in the Journal of Computational and Gradphical
% Statistics
%
% Y. Ann Chen, Moffitt Cancer Center, ann.chen@moffitt.org

[Idelta.C Jdelta.C] = find(observedp<pcutoff);
sparseC = sparse(Idelta.C,Jdelta.C,ones(length(Jdelta.C),1),numOfGene,numOfGene);
sumSparseC = sum(sparseC);
sumDeltaC = full(sumSparseC)';
[listOfAC.B,listOfAC.IX] = sort(sumDeltaC ,'descend');

fid = fopen(fileout,'w');
numAtLeastOne = min(find(listOfAC.B==1))-1;

rankI = memb2(listOfAC.B(1:numAtLeastOne));

fprintf(fid, ['No.\t'  'rank\t'  'Freq\t'    'Affy_ID' '\t' 'Gene Symbol'  '\n']);

for i = 1: numAtLeastOne 
    fprintf(fid, [num2str(i) '.\t' num2str(rankI(i)) '\t'  num2str((listOfAC.B(i)-1)) '\t'   txtAnnotation181{listOfAC.IX(i),1} '\t' txtAnnotation181{listOfAC.IX(i),2} '\n']);
end

fclose(fid)

listOfAC.list = listOfAC.IX(1:numAtLeastOne);