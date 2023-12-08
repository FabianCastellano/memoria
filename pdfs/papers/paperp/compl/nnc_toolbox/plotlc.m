function plotlc(corrOut, opt) 

% plot local correlation (l) and thier estimated achived significance after
% after Bonferroni corretion. 
% SYNTAX plotlc(corrOut, opt) 
% 
% INPUTS: 
%       corrOut, structure variable, the output from lc
%       opt, option for the figure type
%           1 is default, 
%           2 is with more detailed probablity profile along radius R
%           3 output into multiple pages.
%
% see also lc
%
% REFERENCE:
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression, published in the Journal of Computational and Gradphical
% Statistics

% Y. Ann Chen, Moffitt Cancer Center, ann.chen@moffitt.org

if nargin < 2
    opt = 1; %default
end

alpha = 0.05;
ntype = size(corrOut.l,1);
nstep = size(corrOut.l,2);

switch opt
    case 1  % default, as in Figure 3 in the ms
        nRow = ceil(ntype/2);
        for p = 1:ntype
            % Bonferroni correction
            subplot(nRow,2,p)
            plotones =zeros(1,nstep); plotones(corrOut.pl(p,:) <= (alpha/nstep)) =1;
            [AX, H1, H2] = plotyy(corrOut.grid,corrOut.l(p,:),corrOut.grid,plotones,'plot');
            set(get(AX(1),'Ylabel'),'String','\it l','fontSize',10);       
            set(get(AX(2),'Ylabel'),'String','Significance','fontSize',10);
            %set(AX(1),'Ylim',[-2 2])
            %set(AX(1),'Ytick',[-2 0 2])
            set(AX(2),'Ylim',[0 1])
            set(AX(2),'Ytick',[0 1])
            if (p==(ntype-1) || p==ntype)
                set(get(AX(2),'Xlabel'),'String','\it r');
            end
            test = get(AX(2),'Xlabel');
            %set(test, 'FontAngle','italic')
            set(H1,'LineStyle','--')
            set(H2,'LineStyle','.')
            title (['Case ' num2str(p)],'fontSize',10);
        end
    case 2  % as the Figure S3 in the supplement
        i = 0;
        nPage = ceil(ntype/2);
        if mod(ntype,2)==0
        
            for count =1:nPage
                figure
                for p = 1:2
                    i = i+1;

                    subplot(2,2,2*p-1);
                    plot(corrOut.grid,corrOut.l(i,:));
                    xlabel('R','FontAngle', 'Italic'); ylabel('l', 'FontAngle', 'Italic'); ylim([-2 2])
                    title (['Case ' num2str(i)]);

                    subplot(2,2,2*p)
                    plotones =zeros(1,nstep); plotones(corrOut.pl(i,:) <= (alpha/nstep)) =1;
                    [AX, H1, H2] = plotyy(corrOut.grid,corrOut.pl(i,:),corrOut.grid,plotones,'plot');
                    set(get(AX(1),'Ylabel'),'String','p-value');
                    set(get(AX(2),'Ylabel'),'String','Significance');
                    set(get(AX(2),'Xlabel'),'String','R');
                    set(H1,'LineStyle','--')
                    set(H2,'LineStyle','.')
                end
            end
        elseif nPage~=1 % more than one page
        
            for count =1:nPage-1
                figure
                for p = 1:2
                    i = i+1;

                    subplot(2,2,2*p-1);
                    plot(corrOut.grid,corrOut.l(i,:));
                    xlabel('R','FontAngle', 'Italic'); ylabel('l', 'FontAngle', 'Italic'); ylim([-2 2])
                    title (['Case ' num2str(i)]);

                    subplot(2,2,2*p)
                    plotones =zeros(1,nstep); plotones(corrOut.pl(i,:) <= (alpha/nstep)) =1;
                    [AX, H1, H2] = plotyy(corrOut.grid,corrOut.pl(i,:),corrOut.grid,plotones,'plot');
                    set(get(AX(1),'Ylabel'),'String','p-value');
                    set(get(AX(2),'Ylabel'),'String','Significance');
                    set(get(AX(2),'Xlabel'),'String','R');
                    set(H1,'LineStyle','--')
                    set(H2,'LineStyle','.')
                end
            end
            figure
            p=1;
            i = i+1;

            subplot(2,2,2*p-1);
            plot(corrOut.grid,corrOut.l(i,:));
            xlabel('R','FontAngle', 'Italic'); ylabel('l', 'FontAngle', 'Italic'); ylim([-2 2])
            title (['Case ' num2str(i)]);

            subplot(2,2,2*p)
            plotones =zeros(1,nstep); plotones(corrOut.pl(i,:) <= (alpha/nstep)) =1;
            [AX, H1, H2] = plotyy(corrOut.grid,corrOut.pl(i,:),corrOut.grid,plotones,'plot');
            set(get(AX(1),'Ylabel'),'String','p-value');
            set(get(AX(2),'Ylabel'),'String','Significance');
            set(get(AX(2),'Xlabel'),'String','R');
            set(H1,'LineStyle','--')
            set(H2,'LineStyle','.')
        else % only one case
            figure
            p=1;
            i = i+1;

            subplot(2,2,2*p-1);
            plot(corrOut.grid,corrOut.l(i,:));
            xlabel('R','FontAngle', 'Italic'); ylabel('l', 'FontAngle', 'Italic'); ylim([-2 2])
            title (['Case ' num2str(i)]);

            subplot(2,2,2*p)
            plotones =zeros(1,nstep); plotones(corrOut.pl(i,:) <= (alpha/nstep)) =1;
            [AX, H1, H2] = plotyy(corrOut.grid,corrOut.pl(i,:),corrOut.grid,plotones,'plot');
            set(get(AX(1),'Ylabel'),'String','p-value');
            set(get(AX(2),'Ylabel'),'String','Significance');
            set(get(AX(2),'Xlabel'),'String','R');
            set(H1,'LineStyle','--')
            set(H2,'LineStyle','.')   
        end
        
    case 3  % output into multiple pages
        i = 0;
        nPage = ceil(ntype/4);
        if mod(ntype,4)==0
            for count =1:nPage
                figure
                for p = 1:4
                    i = i+1;

                    subplot(2,2,p)
                    plotones =zeros(1,nstep); plotones(corrOut.pl(i,:) <= (alpha/nstep)) =1;
                    [AX, H1, H2] = plotyy(corrOut.grid,corrOut.l(i,:),corrOut.grid,plotones,'plot');
                    set(get(AX(1),'Ylabel'),'String','Local correlation');
                    test = get(AX(1),'Ylabel');
                    set(get(AX(2),'Ylabel'),'String','Significance');
                    test = get(AX(2),'Ylabel');
                    set(get(AX(2),'Xlabel'),'String','R');
                    test = get(AX(2),'Xlabel');               
                    set(test, 'FontAngle','italic')
                    set(H1,'LineStyle','--')
                    set(H2,'LineStyle','.')
                    title (['Case ' num2str(i)]);
                end
            end
        elseif nPage~=1 % more than one page
            for count =1:nPage-1
                figure
                for p = 1:4
                    i = i+1;
                    subplot(2,2,p)
                    plotones =zeros(1,nstep); plotones(corrOut.pl(i,:) <= (alpha/nstep)) =1;
                    [AX, H1, H2] = plotyy(corrOut.grid,corrOut.l(i,:),corrOut.grid,plotones,'plot');
                    set(get(AX(1),'Ylabel'),'String','Local correlation');
                    test = get(AX(1),'Ylabel');
                    set(get(AX(2),'Ylabel'),'String','Significance');
                    test = get(AX(2),'Ylabel');
                    set(get(AX(2),'Xlabel'),'String','R');
                    test = get(AX(2),'Xlabel');               
                    set(test, 'FontAngle','italic')
                    set(H1,'LineStyle','--')
                    set(H2,'LineStyle','.')
                    title (['Case ' num2str(i)]);
                end
            end
            figure
            for p = 1:mod(ntype,4)
                
                i = i+1;
                subplot(2,2,p)
                plotones =zeros(1,nstep); plotones(corrOut.pl(i,:) <= (alpha/nstep)) =1;
                [AX, H1, H2] = plotyy(corrOut.grid,corrOut.l(i,:),corrOut.grid,plotones,'plot');
                set(get(AX(1),'Ylabel'),'String','Local correlation');
                test = get(AX(1),'Ylabel');
                set(get(AX(2),'Ylabel'),'String','Significance');
                test = get(AX(2),'Ylabel');
                set(get(AX(2),'Xlabel'),'String','R');
                test = get(AX(2),'Xlabel');               
                set(test, 'FontAngle','italic')
                set(H1,'LineStyle','--')
                set(H2,'LineStyle','.')
                title (['Case ' num2str(i)]);
           end
        else % only one incomplete page
            figure
            for p = 1:mod(ntype,4)
                i = i+1;
                subplot(2,2,p)
                plotones =zeros(1,nstep); plotones(corrOut.pl(i,:) <= (alpha/nstep)) =1;
                [AX, H1, H2] = plotyy(corrOut.grid,corrOut.l(i,:),corrOut.grid,plotones,'plot');
                set(get(AX(1),'Ylabel'),'String','Local correlation');
                test = get(AX(1),'Ylabel');
                set(get(AX(2),'Ylabel'),'String','Significance');
                test = get(AX(2),'Ylabel');
                set(get(AX(2),'Xlabel'),'String','R');
                test = get(AX(2),'Xlabel');               
                set(test, 'FontAngle','italic')
                set(H1,'LineStyle','--')
                set(H2,'LineStyle','.')
                title (['Case ' num2str(i)]);
           end 
            
        end
end



