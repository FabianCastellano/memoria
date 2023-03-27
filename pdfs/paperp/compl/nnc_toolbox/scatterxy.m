function scatterxy(X, Y, opt, nRows)

% scatter plot of X and Y in original or ranked scale
% SYNTAX: scatterxy(X, Y, opt)
%
% INPUTS: 
%   X,  a N-by-nType matrix, and nType is the number of (X,Y) pairs.
%   Y,  the same dimension as X
%   Opt, 1: original values
%        2: rank scales
%   nRows: number of rows in the figure
%
%% REFERENCE:
% Chen YA, Almeida JS, Richards AJ, Müller P, Carroll RJ. and Baerbel 
% Rohrer. A nonparametric approach to detect local correlation in gene
% expression, published in the Journal of Computational and Gradphical
% Statistics
%
% Y. Ann Chen, Moffitt Cancer Center, ann.chen@moffitt.org

if nargin < 3
    opt = 1;
    nRows = 3;
elseif nargin<4
    nRows = 3;
end

nType = size(X,2);
nCols = ceil(nType/nRows);

switch opt
    case 1
        for i =1:nType
            subplot(nRows,nCols,i); scatter(X(:,i),Y(:,i),'.')
            title(['Case ' num2str(i)],'FontSize',10);xlabel('X','FontSize',10); ylabel('Y','FontSize',10);
        end
    case 2
        for i =1:nType
            subplot(nRows,nCols,i); scatter(memb2(X(:,i)),memb2(Y(:,i)),'.')
            title(['Case ' num2str(i)],'FontSize',10);xlabel('X','FontSize',10); ylabel('Y','FontSize',10);
        end
end


