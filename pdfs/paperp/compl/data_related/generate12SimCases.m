% Matlab scripts used to generate the 12 simulated cases in the manuscript

% addapath to the folder with the following dataset and Matlab functions: 
%       1. sim2.m
%       2. trasform.m
%       3. the datafile: Dataset_1_for_mat.txt 

% addpath C:\xxx\xxx
clear

% number of data points
n = 100;
n1 = 20;
n2 = 50;
n3 = 70;

% the power N for the curve
powerN = 2;

% # simulated cases
ntype = 12;

%%       1. Case 1: Random
         x = [1:n];
         y.rand = rand(1,n); 
        
         
%%       2 Case 2: a perfect linear relationship
            y.lin = 3*x;
                             

%%       3. Case 3: 7 non-decreasing broken straight lines
            y.linZig = sim2(x,1);  
             
            
%%       4. Case 4: Broken straight lines (both positive, negative correlation, and horizontal; not monotonic)            
            y.linZigNonmono = sim2(x); 
             
%%       5. Case 5: continuous monotonically increasing curve

            y.cur = x.^powerN;
             
%%       6. Case 6: broken monotonically increasing curves
            y.curbk = sim2(x,2, powerN);
             

%%       7. Case 7: three segments of sine waves.
            y.curbkNonmono = sim2(x,3);
            
%%       8. Case 8 is a mixture distribution of Cases 1 and 4
           
            y.mix1 = zeros(1,n);
            y.mix1(1:n1) = y.linZigNonmono(1:n1);
            y.mix1(n1+1:n2) = y.rand(n1+1:n2)*100;
            y.mix1(n2+1:n3)= y.linZigNonmono(n2+1:n3);
            y.mix1(n3+1:n)= y.linZigNonmono(n3+1:n)*(-0.1);
            
%%        9. Case 9 is a mixture of Cases 1 and 7.
            y.mix2 = zeros(1,n);
            y.mix2(1:n1) = y.curbkNonmono(1:n1);
            y.mix2(n1+1:n2) = y.rand(n1+1:n2)*10;
            y.mix2(n2+1:n3)= y.curbkNonmono(n2+1:n3);
            y.mix2(n3+1:n)= y.rand(n3+1:n)*10;

            y.raw = [y.rand; y.lin; y.linZig; y.linZigNonmono;  y.cur; y.curbk; y.curbkNonmono;y.mix1; y.mix2];
%%         10. case 10. The 3 clusters randomly sampled 1/3 of the 300 points in dataset 
%%               1 from Jonnalagadda and Srinivasan (2004)

            Dataset_1_for_mat= importdata('Dataset_1_for_mat.txt');
            test=randperm(300);
            % scatter(Dataset_1_for_mat(test(1:100),3), Dataset_1_for_mat(test(1:100),4),'.');
            simY = y.raw';
            simY(:,10)= Dataset_1_for_mat(test(1:100),4);
            simX = repmat(x', 1, 9);
            simX(:,10)= Dataset_1_for_mat(test(1:100),3);

                
%%         11. case 11, Two-fifths of the data points are randomly sampled 
%               from Case 1 while 3/5 of the data are randomly sampled from 
%               Case 10.
            testX = trasform(simX(:,1), min(simX(:,10)), max(simX(:,10)));
            testY = trasform(simY(:,1), min(simY(:,10)), max(simY(:,10)));
            rand1 = randperm(100); 
            rand2 = randperm(100);
            simX(1:40,11) = testX(rand1(1:40));
            simY(1:40,11) = testY(rand1(1:40));
            simX(41:100,11) = simX(rand2(1:60),10);
            simY(41:100,11) = simY(rand2(1:60),10);

%%         12. case 12: composed of 3/5 of case 10, and 2/5 two new clusters

            potato1 = mvnrnd([620 290],[15 10; 10 18],20);
            potato2 = mvnrnd([660 260],[10 6;6 18],20);
            simX(1:40,12) = [potato1(:,1);potato2(:,1)];
            simY(1:40,12) = [potato1(:,2);potato2(:,2)];
            simX(41:100,12) = simX(rand2(1:60),10);
            simY(41:100,12) = simY(rand2(1:60),10);
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% save twelveCases.mat
