%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  The script to simulate 100 realizations for each of the cases 
% with stochastic components, i.e., Cases 1 and 8 through 12.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. addpath xxx for loading the matfile: twelveCases.mat 
% 2. originally, the seed for rand is generated using cputime (as commented 
%       out). To generate the same simulated dataset, one could load the 
%       saved seed, seedforPR.mat. 

clear

%% Case 1

% originally:
seeforms1=cputime;
% if one would like to generate the same simulated dataset, load the same
% seed, otherwise, comment this one out.
load seedforPR.mat
n=100;
nSim=100;
rand('seed', seeforms1)
X1=zeros(n,nSim);
Y1=zeros(n,nSim);

for i = 1:nSim
    X1(:,i) = rand(n,1);
    Y1(:,i) = rand(n,1); 
end

% save the simulated data
% save xxx

%% Case 10

n=100;
nSim=100;
X10=zeros(n,nSim);
Y10=zeros(n,nSim);
Dataset_1_for_mat= importdata('Dataset_1_for_mat.txt');
q=length(Dataset_1_for_mat);
seeforms10=cputime;
% if one would like to generate the same simulated dataset, load the same
% seed, otherwise, comment this one out.
load seedforPR.mat
rand('seed', seeforms10)
for i=1:nSim
    test=randperm(q);
    Y10(:,i)= Dataset_1_for_mat(test(1:100),4);
    X10(:,i)= Dataset_1_for_mat(test(1:100),3);
end

% save the simulated data
% save xxx


%% Case 11

X11=zeros(n,nSim);
Y11=zeros(n,nSim);
seeforms11=cputime;
% if one would like to generate the same simulated dataset, load the same
% seed, otherwise, comment this one out.
load seedforPR.mat
rand('seed', seeforms11)        
n1=40;
  for i =1:nSim
    testX = trasform(X1(:,i), min(X10(:,i)), max(X10(:,i)));
    testY = trasform(Y1(:,i), min(Y10(:,i)), max(Y10(:,i)));
    rand1 = randperm(n); 
    rand2 = randperm(n);
    X11(1:n1,i) = testX(rand1(1:n1)); % from case 1
    Y11(1:n1,i) = testY(rand1(1:n1)); % from case 1
    X11((n1+1):n,i) = X10(rand2(1:(n-n1)),i);
    Y11((n1+1):n,i) = Y10(rand2(1:(n-n1)),i);
  
  end

% save the simulated data
% save xxx


%% Case 12: composed of 3/5 of case 10, and 2/5 two new clusters
seeforms12=cputime;
% if one would like to generate the same simulated dataset, load the same
% seed, otherwise, comment this one out.
load seedforPR.mat
rand('seed', seeforms12)
X12=zeros(n,nSim);
Y12=zeros(n,nSim);
 for i = 1:nSim
    potato1 = mvnrnd([620 290],[15 10; 10 18],20);
    potato2 = mvnrnd([660 260],[10 6;6 18],20);
    rand2 = randperm(n);
    X12(1:n1,i) = [potato1(:,1);potato2(:,1)];
    Y12(1:n1,i) = [potato1(:,2);potato2(:,2)];
    X12((n1+1):n,i) = X10(rand2(1:60),i);
    Y12((n1+1):n,i) =Y10(rand2(1:60),i);
 end
% save the simulated data
% save xxx


%% CASE 8, a mixture of Cases 1 and 4 %%%%%%%%%%%%%%%%%%%%%%
clear
load twelveCases.mat
% define the path for output mat file
% outfile= 'C:\xxx';
n = 100;
n1 = 20;
n2 = 50;
n3 = 70;
nSim=100;
caseN=8;
tic
seeforms8=cputime;
% if one would like to generate the same simulated dataset, load the same
% seed, otherwise, comment this one out.
load seedforPR.mat
rand('seed', seeforms8)

X=repmat(x',1,nSim);
Yvect(1:n1,1) = y.linZigNonmono(1:n1);
Yvect(n1+1:n2,1) = y.rand(n1+1:n2)*100;
Yvect(n2+1:n3,1)= y.linZigNonmono(n2+1:n3);
Yvect(n3+1:n,1)= y.linZigNonmono(n3+1:n)*(-0.1);
Y=repmat(Yvect,1,nSim);

for i = 1:nSim
    y.rand = rand(1,n); %%       
    Y(n1+1:n2,i) = y.rand(n1+1:n2)*100;
end

% save the simulated data
% eval(['save ' outfile 'Case' num2str(caseN) '.mat X Y seeforms' num2str(caseN)]);
toc

%% CASE 9, a mixture of Cases 1 and 7. %%%%%%%%%%%%%%%%%%%%%%
clear 
load twelveCases.mat

% define the path for output mat file
% outfile= 'C:\xxx';
n = 100;
n1 = 20;
n2 = 50;
n3 = 70;
nSim = 100;
caseN = 9;
seeforms9=cputime;
% if one would like to generate the same simulated dataset, load the same
% seed, otherwise, comment this one out.
load seedforPR.mat
rand('seed', seeforms9)
X = repmat(x',1,nSim);
Yvect = zeros(n,1);
Yvect(1:n1,1) = y.curbkNonmono(1:n1)';
Yvect(n1+1:n2,1) = y.rand(n1+1:n2)'*10;
Yvect(n2+1:n3,1) = y.curbkNonmono(n2+1:n3)';
Yvect(n3+1:n,1) = y.rand(n3+1:n)'*10;
Y=repmat(Yvect,1,nSim);

for i = 1:nSim
    y.rand = rand(1,n); %%       
    Y(n1+1:n2,i) = y.rand(n1+1:n2)*10;
    Y(n3+1:n,i) = y.rand(n3+1:n)*10;
end
% save the simulated data
%eval(['save ' outfile 'Case' num2str(caseN) '.mat X Y seeforms' num2str(caseN)]);
