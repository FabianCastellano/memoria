
function scatterdeltastats(corrPw,pcutoff)
% scatter plot to show the relationship between two delta statistics, 
% deltaM and deltaC.
% SYNTAX: scatterdeltastats(corrPw,pcutoff)
%
% INPUTS: 
%   corrPw:  structure variable of pairwise correlation, 
%             the output from function lcchange
%   pcutoff:  p-value cut-off to decide the significane of the statitics.
%
% see also lcchange
%
% REFERENCE:
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression 
% 
% Ann Chen, TAMU, 2006

% pcutoff(1), 2, 3 are for delta T M C, respectively.

numOfComps = size(corrPw.deltaM,1);
label_deltaCM.FDR005 = zeros(numOfComps,1);
label_deltaCM.FDR005(setdiff(find(corrPw.pOfdeltaC<pcutoff(3)), find(corrPw.pOfdeltaM<pcutoff(2) )))=1; % deltaC only
label_deltaCM.FDR005(setdiff(find(corrPw.pOfdeltaM<pcutoff(2)), find(corrPw.pOfdeltaC<pcutoff(3))))=2; % deltaM only
label_deltaCM.FDR005(intersect(find(corrPw.pOfdeltaC<pcutoff(3)), find(corrPw.pOfdeltaM<pcutoff(2) )))=3; % both, only intersect 9
figure; gscatter(corrPw.deltaC, corrPw.deltaM, label_deltaCM.FDR005,'bgrm','.ox<');                  
xlabel('deltaC'); ylabel('deltaM');legend('No change', 'Only sig deltaC', 'Only sig deltaM', 'Sig both stat')
