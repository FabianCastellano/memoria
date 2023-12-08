function stdRankX = memb2(xo)

% syntax stdRankX = memb(xo)
% calculate standardized rank values, that is rank the values and then 
% standardize them between 0 and 1 for the input vector xo
% using mean ranks (instead of upper bound) for the tied ranks. 
%
% REFERENCE:
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression, published in the Journal of Computational and Gradphical
% Statistics
%
% Jonas Almeida and Ann Chen

   [x ix] = sort(xo(:));
   n = length(x);
   i = 0;
   rankX =[1:n];
   while i< n-1
        i = i+1;    

        ind.minX = i; %min tied rank
        ind.ct = 1;
        while (i < n)&(x(i)== x(i+1))
            ind.maxX = i+1; % max tied rank
            ind.ct = ind.ct+1; % numbers of tied rank 
            i = i+1;
        end
        
        if ind.ct~=1 % if there is any tied ranks
            rankX(ind.minX:ind.maxX) = repmat((sum(ind.minX:ind.maxX)/ind.ct),ind.ct,1);
        end
        
        clear ind
   end
    
   minRankX=min(rankX);
   maxRankX =max(rankX);
   y = (rankX-minRankX)./(maxRankX-minRankX);
   stdRankX(ix) = y;
   stdRankX =  stdRankX';
