function y = sim2(x,opt, powerN)

% used for simulation of Cases 3, 4, 6, and 7
% x: input vector x
% opt: to decide which case to simulate
%       without option variable: Case 4
%       opt=1: Case 3
%       opt=2: Case 6
%       opt=3: Case 7

n = numel(x);
tPoint = (n/10);

if nargin <2  
    
    for i = 1:n % Case 4: broken lines
        if (x(i)>0 & x(i) <tPoint) 
            y(i) = 3*x(i);
        elseif (x(i)>= tPoint & x(i) < tPoint*2)
            y(i) = 2;
        elseif (x(i)> tPoint*2 & x(i) < tPoint*3)
            y(i) = -0.5*x(i);
        elseif (x(i)>= tPoint*3 & x(i) < tPoint*4)
            y(i) = 4;
        elseif (x(i)>= tPoint*5 & x(i) < tPoint*6)
            y(i) = -x(i);
        elseif (x(i)>= tPoint*6 & x(i) < tPoint*7)
            y(i) = 0.6*x(i);
        else
            y (i) = -0.3*x(i);
        end
    end
    
elseif (opt == 1) % Case 3: 7 non-decreasing broken straight lines
       for i = 1:n 
            if (x(i)>0 & x(i) <tPoint) 
                y(i) = .3*x(i);
            elseif (x(i)>=tPoint & x(i) <tPoint*3)
                y(i) = 8;
            elseif (x(i)>=tPoint*3 & x(i) <tPoint*5)
                y(i) = x(i);
            elseif (x(i)>=tPoint*5 & x(i) <tPoint*6)
                y(i) = 10;
            elseif (x(i)>=tPoint*6 & x(i)< tPoint*7)
                y(i) = 20;
            elseif (x(i)>=tPoint*7 & x(i) <tPoint*9)
                y(i) = .5*x(i);
            else
                y (i) = x(i);
            end
       end
elseif (opt == 2)% Case 6: broken monotonically increasing curves
    for i = 1:n 
        if (x(i)>0 & x(i) <tPoint*2) 
            y(i) = x(i).^powerN;
        elseif (x(i) == tPoint*2)
            y(i) = x(i).^powerN + 2000;
        elseif (x(i)>= tPoint*2 & x(i) <tPoint*5)
            y(i) = 2000 + x(i).^powerN;
        elseif (x(i)>= tPoint*5)
            y(i) = 8000 + x(i).^powerN;
        else
            y(i) = 9000 + x(i).^powerN;
        end
    end
    
elseif (opt==3) % Case 7
     y = linspace(0,1,n);  
     y = 4*sin(4*pi*y) - sign(y-0.3) - sign(0.72-y);
end
