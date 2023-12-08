function dxdt=ponto3(t,x)

% function dxdt=ponto3(t,x)
% Aplica método dos 3 pontos à matrix x,
% + nos extremos usa o valor do declive 
% do segmento terminal
% Importante: se apenas há um argumento de entrada
% a primeira coluna será usada como t e o resto como x

% 29 Set 99: Oeiras, Jonas Almeida

if nargin<2 % if only one input argument is provided
   [n,m]=size(t);
   x=t(:,2:m);
   t=t(:,1);
end

[n,m]=size(x);

x=x+rand(n,m)*0.00001*max(max(x));  % trick to avoid division by zero errors:

if n~=length(t);error('dimensões de tx e x incompatíveis');end

for i=2:n-1 % para cada linha
   for j=1:m % para cada coluna de y
      A1=t(i-1);
      A2=t(i);
      A3=t(i+1);
      B1=x(i-1,j);
      B2=x(i,j);
      B3=x(i+1,j);
      dxdt(i,j)=((((B2+B3)/2-((A2-A3)/(B3-B2))*(A2+A3)/2)-((B1+B2)/2-((A1-A2)/(B2-B1))*(A1+A2)/2))/((A1-A2)/(B2-B1)-(A2-A3)/(B3-B2))-A2)/(B2-((A1-A2)/(B2-B1))*((B2+B3)/2-((A2-A3)/(B3-B2))*(A2+A3)/2-(B1+B2)/2+((A1-A2)/(B2-B1))*(A1+A2)/2)/((A1-A2)/(B2-B1)-(A2-A3)/(B3-B2))-(B1+B2)/2+((A1-A2)/(B2-B1))*(A1+A2)/2);
   end
end

% Calculo dos declives nos pontos iniciais e terminais

i=1;
for j=1:m
   dxdt(i,j)=(x(i+1,j)-x(i,j))/(t(i+1)-t(i));
end
i=n;
for j=1:m
   dxdt(i,j)=(x(i,j)-x(i-1,j))/(t(i)-t(i-1));
end


