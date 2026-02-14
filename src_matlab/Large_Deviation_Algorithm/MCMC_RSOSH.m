function [ress,HH]=MCMC_RSOSH(L,time,cc,pr,THETA1)
% This is the main function "main" for simulating the height distribution of the RSOS model under the method of large deviation. 
% Input: L base size, time for simulation, cc number of repetitions, pr proportion of random matrix change, THETA1 distribution bias coefficient. 
% Output: The high-probability distribution function under this bias coefficient, where HH represents the original height data.

    HH=zeros(1,cc);
%HHmax stores the extreme value data obtained after so many calculations.
    Acep=zeros(1,cc);
%Acep was conducted to investigate the issue of the acceptance rate of pr for the corresponding THETA1. The acceptance rate should be close to 0.5.

    R_Mx=randn(L,time); 
    Hx=RSOSH(L,time,R_Mx);
    for p=1:cc
        R_My=R_Mx;
        R_My(randperm(L*time,ceil(pr*L*time)))=randn(ceil(pr*L*time),1);
        Hy=RSOSH(L,time,R_My);
        rp=min([1,exp(-(THETA1)*(Hy-Hx))]);
        if rand<rp
            R_Mx=R_My;
            Hx=Hy;
            Acep(1,p)=rp;
        end
        HH(1,p)=Hx;
    end

    Acept(1)=mean(Acep(1,:));
    Acept
%Acept代表着平均接受率。
    ress=getRes1(HH);