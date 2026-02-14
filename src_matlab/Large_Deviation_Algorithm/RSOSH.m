function [H]=RSOSH(L,time,R_M)
% This is a function for calculating the height result of the RSOS model, and the output is the height value at a certain position on the interface. 
% Input: L is the base size of the system, time is the number of parallel update steps in the simulation, and R_M is the noise matrix. 
% Output: The height value at a certain position on the RSOS model interface.

h=zeros(1,L+2);hh=zeros(1,L+2);
s=1;
for tt=1:time
    Rs0=R_M(:,tt);
    Rs0=(Rs0>0);
    for x=2:L+1
        if abs(hh(x)+1-hh(x-1))<=s && abs(hh(x)+1-hh(x+1))<=s
                h(x)=hh(x)+Rs0(x-1);
        end
    end
    h(1)=h(L+1);h(L+2)=h(2);
    hh=h;
end
H=-h(ceil(L/2));