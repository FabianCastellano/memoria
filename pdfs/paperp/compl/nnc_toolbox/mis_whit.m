function [z,mis]=mis_whit(x,y,caso,opt)

%MIS_WHIT miscelaneous work towards optimal automated Eilres filtering
%Syntax: [z,mis]=mis_whit(x,y,caso,opt)
%
%Input:
%  x - temporal corrdinates of sampling events
%  y - measured values
%  caso - swicth toggle
%  opt - optinonal input data
%
%Outputs:
%  z - smoothed signal
%  mis - structured variable with miscelaneous results

z=[];mis=[];
if isempty(x);x=[1:length(y)]';end
switch caso
    case 'xy' % simple plot of signal
        plot(x,y,'.');
    case 'sgs' % general call to Savitzky-Golay Smoother
        % Look for opt settings
        m=length(y);
        if ~exist('opt');opt=[];end
        %if isfield(opt,'w');w=opt.w;else;w=ones(m,1);end
        if isfield(opt,'lambdas');lambdas=opt.lambdas;else;lambdas=10.^(0:.2:6);end
        if isfield(opt,'d');d=opt.d;else;d=2;end
        for j=1:length(d)
            for i=1:length(lambdas)
                %[z(:,i,j),mis.cve(i,j),mis.h{i,j}]=whitsmddw(x,y,w,lambdas(i),d(j));
                [z(:,i,j),mis.cve(i,j),mis.h{i,j}]=whitsm(y,lambdas(i),d(j));
            end
        end
        mis.lambdas=lambdas;opt.d=d;
    case 'xyz' % plot xyz, calculates z if it doesn't exist
    case 'xyzL' % screens lambdas for a given signal
        if ~exist('opt');opt=[];end
        [z,mis]=mis_whit(x,y,'sgs',opt);
        [n,m]=size(z);
        subplot(2,1,1)
        plot(x,z,'b-')
        hold on
        plot(x,y,'k.')
        %for i=1:m
        %    plot(x,z(:,i))
        %end
        hold off
        subplot(2,1,2);
        loglog(mis.lambdas,mis.cve)
        [cvemin,Lind]=min(mis.cve);
        mis.Lmin=mis.lambdas(Lind);mis.Lind=Lind;mis.z=z(:,Lind);
        hold on
        plot(mis.lambdas(Lind),mis.cve(Lind),'o','color','r')
        hold off
        subplot(2,1,1)
        hold on
        plot(x,z(:,Lind),'r-','LineWidth',1.5)
        hold off
    case 'manual' % Screen lambdas and orders (d) for a given signal
        if ~exist('opt');opt=[];end
        if ~isfield(opt,'d');opt.d=[1:5];end
        [z,mis]=mis_whit(x,y,'sgs',opt);
        [n,m,k]=size(z);c='bgrcm';
        subplot(2,2,1)
        hold on
        for i=1:k
            j=i-floor(i/5-0.1);
            plot(x,z(:,:,i),[c(j),'-']);
        end
        plot(x,y,'k.')
        %for i=1:m
        %    plot(x,z(:,i))
        %end
        [mm,ind]=min(mis.cve(:));[I1,I2]=ind2sub(size(mis.cve),ind);
        plot(x,z(:,I1,I2),'k-');
        mis.zopt=z(:,I1,I2);
        xlabel('x');ylabel('y')
        hold off
        subplot(2,2,3);
        hold on
        for i=1:k
            j=i-floor(i/5-0.1);
            plot(mis.lambdas',mis.cve(:,i),'color',c(j));
            [cvemin,Lind]=min(mis.cve(:,i));
            mis.cvemin(i)=cvemin;
            mis.Lmin(i)=mis.lambdas(Lind);
            mis.Lind(i)=Lind;%mis.z=z(:,Lind);
            plot(mis.lambdas(Lind),mis.cve(Lind,i),'*','color',c(j))
        end
        xlabel('smoothing weight (lambda)')
        ylabel('cross validated Err (cve)')
        %[cvemin,Lind]=min(mis.cve);
        %mis.Lmin=mis.lambdas(Lind);mis.Lind=Lind;mis.z=z(:,Lind);
        % Find optimal solution
        hold off
        %subplot(2,1,1)
        %hold on
        %plot(x,z(:,Lind),'r-','LineWidth',1.5)
        %hold off        
        %Make seccond plot really log-log
        G=get(gcf);set(G.Children(1),'XScale','log','YScale','log')
        %Make forst plot go accross top
        G2=get(G.Children(2));P=G2.Position;P(3)=1-2*P(1);set(G.Children(2),'Position',P);
        mis.d=opt.d;
        subplot(2,2,4);
        hold on
        for i=1:k
            j=i-floor(i/5-0.1);
            plot(mis.d(i),mis.cvemin(i),[c(j),'*'])
        end
        xlabel('order (d)')
        ylabel('cross validated Err (cve)')
        % Signal optimal selection:
        [mis.optcve,optd]=min(mis.cvemin);
        plot(mis.d(optd),mis.optcve,'ko')
        hold off
        %subplot(2,2,2)
        %hold on
        %plot(x,z(:,Lind,optd),'k-')
        %hold off
        [lala,mis.d_opt]=min(mis.cvemin);
        mis.labmda_opt=mis.lambdas(mis.d(mis.d_opt));
    case 'auto' %automated filtering, parameters are sought by min corssvalidated error
        if ~exist('opt');opt=[];end
        if ~isfield(opt,'d');opt.d=[1:5];end
        [z,mis]=mis_whit(x,y,'sgs',opt);
        [mm,ind]=min(mis.cve(:));[I1,I2]=ind2sub(size(mis.cve),ind);
        z=z(:,I1,I2);
        mis=opt;
        mis.x=x;
        mis.y=y;
        mis.z=z;
        mis.dz=ponto3(x,z);
    case 'autoplot' %like auto but also plots series
        if ~exist('opt');opt=[];end
        if ~isfield(opt,'d');opt.d=[1:5];end
        [z,mis]=mis_whit(x,y,'auto',opt);
        plot(x,y,'k.');
        hold on;plot(x,z,'b-','LineWidth',1.5);hold off
        xlabel('x');ylabel('y (symbol) ,z (line)')
    case 'automemb' % using auto with quantilization and dequantilization
        if ~exist('opt');opt=[];end
        if ~isfield(opt,'d');opt.d=[1:5];end
        [yy,dt]=memb(y);
        [zz,mis]=mis_whit(x,yy,'auto',opt);
        z=memb(zz,dt(:,[2:-1:1]));
        %z=mis_whit(x,z,'auto',opt); % <--- trial basis
    case 'automembplot'
        if ~exist('opt');opt=[];end
        if ~isfield(opt,'d');opt.d=[1:5];end
        z=mis_whit(x,y,'automemb',opt);
        plot(x,y,'k.');
        hold on;plot(x,z,'b-','LineWidth',1.5);hold off
        xlabel('x');ylabel('y (symbol) ,z (line)')
    otherwise
        
        disp(['Switch toggle "',caso,'" not defined'])
end
    