function [H]=RSOSHFFGN(L,time,th0,R_M)
% This is a function for calculating the height result of the long-range time correlation RSOS model. The output is the height value at a certain position on the interface. 
% Input: L is the base size of the system, time is the number of parallel update steps in the simulation, th0 is the time correlation index, and R_M is the noise matrix. 
% Output: The height value at a certain position on the interface of the long-range time correlation RSOS model.

s=1;
N0=40;
ss=(1:N0);Un=6*2.^(-ss);Rn=exp((-Un));
wn=sqrt((12*(1-Rn.^2).*(2^(0.5-th0)-2^(th0-0.5)).*Un.^(1-2*th0))/gamma(2-2*th0));
h=zeros(1,L+2);hh=zeros(1,L+2);
for tt=1:time
    cx=R_M(:,:,tt);
    if tt==1
        X1=power((1-power(Rn,2)),-1/2).*(cx-0.5);
        Rs0=wn*(X1.');      
        Rs0=(Rs0>0);
    
    elseif tt~=1
        X2=Rn.*X1+(cx-0.5);
        Rs0=wn*(X2.'); 
        Rs0=(Rs0>0);
        X1=X2;
    end
    for x=2:L+1
        if abs(hh(x)+1-hh(x-1))<=s && abs(hh(x)+1-hh(x+1))<=s
            h(x)=hh(x)+Rs0(x-1);
        end
    end
    h(1)=h(L+1);h(L+2)=h(2);
    hh=h;
end
H=-h(ceil(L/2));
