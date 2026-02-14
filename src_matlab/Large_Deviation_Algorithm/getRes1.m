function res=getRes1(data)
%This is to calculate the proportion of different heights in relation to the total height. 
% Input: Data on the distribution of system heights. 
% Output: The proportions of each height component.

data=data(:);
xmin=min(data); 
xmax=max(data);  
pin=linspace(xmin,xmax,(xmax-xmin+1));
N=histcounts(data,pin);
res=zeros(length(N),2);
res(:,1)=pin(1:length(N));
res(:,2)=N./sum(N);
