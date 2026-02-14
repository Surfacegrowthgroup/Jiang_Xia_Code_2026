function H=BDHFFGN_SC(L,time,th0,R_M)
% This is a function for calculating the height result of the long-range spatial correlation BD model. The output is the height value at a certain position on the interface. 
% Input: L is the base size of the system, time is the number of parallel update steps in the simulation, th0 is the time correlation index, and R_M is the noise matrix. 
% Output: The height value at a certain position on the interface of the long-range spatial correlation BD model.
N0=40;
ss=(1:N0);Un=6*2.^(-ss);Rn=exp((-Un));
wn=sqrt((12*(1-Rn.^2).*(2^(0.5-th0)-2^(th0-0.5)).*Un.^(1-2*th0))/gamma(2-2*th0));
h=zeros(1,L+2);hh=zeros(1,L+2);
noz=zeros(time,L);
for tt=1:L
    cx=R_M(:,:,tt);
    if tt==1
        X1=power((1-power(Rn,2)),-1/2).*(cx-0.5);
        noz(:,tt)=(wn*(X1.')>0);      
    elseif tt~=1
        X2=Rn.*X1+(cx-0.5);
        noz(:,tt)=(wn*(X2.')>0); 
        X1=X2;
    end
end
noz=noz';
for tt=1:time
    noz1=noz(:,tt);
    for i=2:L+1
        h(i)=max([hh(i)+noz1(i-1),hh(i-1),hh(i+1)]);
    end
    h(1)=h(L+1);h(L+2)=h(2);
    hh=h;
end
H=h(ceil(L/2));
