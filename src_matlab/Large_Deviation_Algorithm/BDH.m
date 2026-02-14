function [H]=BDH(L,time,R_M)
% This is a function for calculating the height result of the BD model, and the output is the height value at a certain position on the interface. 
% Input: L is the base size of the system, time is the number of parallel update steps in the simulation, and R_M is the noise matrix. 
% Output: The height value at a certain position on the BD model interface.
h=zeros(1,L+2);hh=zeros(1,L+2);
for tt=1:time
    Rs0=R_M(:,tt);   
    Rs0=(Rs0>0);
    for i=2:L+1
        if hh(i)+Rs0(i-1)>hh(i-1) && hh(i)+Rs0(i-1)>hh(i+1)
            nm=hh(i)+Rs0(i-1);
        elseif hh(i-1)>hh(i)+Rs0(i-1) && hh(i-1)>hh(i+1)
            nm=hh(i-1);
        else
            nm=hh(i+1);
        end
        h(i)=nm;
    end  
    h(1)=h(L+1);h(L+2)=h(2);
    hh=h;
end
H=h(L/2);
