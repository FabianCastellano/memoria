function out = corr_integrallocal(x,y,opt,m,plt)

% calculate correlation integrals (I) and neighbor densities (D) for the 
% the estimate of local correlation
% Syntax: out = corr_integrallocal4(x,y,m,plt)
% Inputs: x and y: two column vectors of the same size
%         opt: default, opt=1, ranked scales; opt=2, raw value
%         m: an integer to define grid size for radius r 
%         plt: optional for plots
% Output: out, a structured variable with the results of the 
%              calculation
% 
% REFERENCE:
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression, published in the Journal of Computational and Gradphical
% Statistics
%
% Ann Chen & Jonas S. Almeida, ann.chen@moffitt.org


N = length(x);

if nargin<2
    error('At least two input variables are needed!')
elseif nargin < 3
    opt=1;  
elseif nargin<4
    m=N;
end

out.x = x;
out.y = y;

if opt==1 % use rank  and standardized data(between 0 and 1).
    x = memb2(x);
    y = memb2(y);
    out.d = sqrt((repmat(x,1,N)-repmat(x',N,1)).^2+(repmat(y,1,N)-repmat(y',N,1)).^2);%distance matrix
else % use raw values
    out.d = sqrt((repmat(x,1,N)-repmat(x',N,1)).^2+(repmat(y,1,N)-repmat(y',N,1)).^2);%distance matrix
end

% standardize the distance from 0 to 1 
out.d = out.d./max(max(out.d));
out.Int.d = [0:1/m:1]; % grid for radius r (standardized between [0 1])

% cummulative neighbors I within radius r 
out.Int.I = zeros(1,m);
for i=1:m+1
    out.Int.I(i)=(sum(sum(out.d<=out.Int.d(i))))./(N^2); 
end

xx = [out.Int.d(1:end-1);out.Int.d(2:end)];
xx = xx(2,:)-xx(1,:);  % dx, unit radius
yy = [out.Int.I(1:end-1);out.Int.I(2:end)]; 

% Neighbor density D 
out.Int.dI = (yy(2,:)-yy(1,:))./xx; 
out.Int.dI = mis_whit([],out.Int.dI','auto')';  


if nargin>4
    switch plt
        case 1
            subplot(2,1,1);
            plot(out.Int.d',out.Int.I');
            legend('cummulative neighbors',-1);
            xlabel('quantile distance');
            grid on
            subplot(2,1,2);
            plot(x,y,'+')
        case 2
            [AX,H1,H2] = plotyy(out.Int.d,out.Int.I,out.Int.d(2:end),out.Int.dI,'plot');
            set(H1,'LineStyle','.')
            set(H2,'LineStyle','.')
            set(get(AX(1),'Ylabel'),'String','Left Y-axis')
            set(get(AX(2),'Ylabel'),'String','Right Y-axis')
    
        case 6
            
            subplot(2,2,1)
            plot(out.x,out.y,'.','Color',[0 0 0])
            xlabel('X');ylabel('Y');
            title('raw values')
            
            subplot(2,2,2)
            plot(x,y,'.','Color',[0 0 0])
            xlabel('X');ylabel('Y');
            title('quantile values')
            
            subplot(2,2,3)
            plot(out.Int.d',out.Int.I','LineWidth',4,'Color',[0 0 0]);
            hold on
            plot(out.Int.d(2:end),out.Int.dI,'LineWidth',4,'Color',[0.5 0.5 0.5]);
           
            G=get(gcf);
            set(G.Children(1),'OuterPosition',[-0.05 0 1 0.4985]);
            xlabel('quantile distance'); legend({'Cummulative neighbors','Neighbor density'})
            grid on
            title('correlation integral between X and Y')
            hold off;
       case 7
            
            subplot(2,2,1)
            plot(out.x,out.y,'.','Color',[0 0 0])
            xlabel('X');ylabel('Y');
            title('raw values')
            
            subplot(2,2,2)
            plot(x,y,'.','Color',[0 0 0])
            xlabel('X');ylabel('Y');
            title('Std quantile values')
            
            subplot(2,2,3)
            plot(out.Int.d',out.Int.I','LineWidth',4,'Color',[0 0 0]);
            hold on
            plot(out.Int.d(2:end),out.Int.dI,'LineWidth',4,'Color',[0.5 0.5 0.5]);
           
            G=get(gcf);
            set(G.Children(1),'OuterPosition',[-0.05 0 1 0.4985]);
            xlabel('std quantile distance'); legend({'I','D'},'FontAngle','italic')
            grid on
            title('correlation integral between X and Y')
            hold off;
    end
end
    
    
    
    