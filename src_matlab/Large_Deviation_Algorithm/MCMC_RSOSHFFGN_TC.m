function [ress,HH]=MCMC_RSOSHFFGN_TC(L,time,cc,th0,pr,THETA1)
% This is the main function "main" for calculating the height distribution of the long-range time-correlated RSOS model under the simulation calculation of the large deviation method. 
% Input: L base size, time simulation duration, cc repetition times, th0 is the time correlation index, pr is the proportion of random matrix change, THETA1 is the distribution bias coefficient. 
% Output: The high-probability distribution function under this bias coefficient, where HH represents the original height data.

N0=40;
a=size(THETA1);
HH=zeros(1,cc);
%HH stores the height data that has been sampled based on its importance.
Acep=zeros(1,cc);
%Acep was conducted to investigate the issue of the acceptance rate of pr for the corresponding THETA1. The acceptance rate should be close to 0.5.
for c=1:a(2)
    pr1=pr(c);
    R_Mx=rand(L,N0,time);
    H_Mx=RSOSHFFGN(L,time,th0,R_Mx);
    for p=1:cc
        R_My=CH_GE(R_Mx,pr1,L,N0,time);
        H_My=RSOSHFFGN(L,time,th0,R_My);
        rp=min([1,exp(-(THETA1(c)*(H_My-H_Mx)))]);
        if rand<rp
            R_Mx=R_My;
            H_Mx=H_My;
            Acep(c,p)=rp;
        end
        HH(c,p)=H_Mx;
        
    end
end
for i=1:a(2)
    Acept(i)=mean(Acep(i,:));
end
sum(Acep(1,:))
Acept
%Acept代表着平均接受率。
ress=getRes1(HH);