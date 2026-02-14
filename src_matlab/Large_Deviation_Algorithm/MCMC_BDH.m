function [ress,HH]=MCMC_BDH(L,time,cc,pr,THETA1)
% This is the main function "main" for simulating the height distribution of the BD model under the method of large deviation. 
% Input: L base size, time for simulation, cc number of repetitions, pr proportion of random matrix change, THETA1 distribution bias coefficient. 
% Output: The high-probability distribution function under this bias coefficient, HH represents the original height data. 
    HH=zeros(1,cc);
%HH stores the height data after undergoing importance sampling. 
    Acep=zeros(1,cc);
%Acep was conducted to investigate the issue of the acceptance rate of pr for the corresponding THETA1. The acceptance rate should be close to 0.5.
    R_Mx=randn(L,time); 
    Hx=BDH(L,time,R_Mx);
    for p=1:cc
        R_My=R_Mx;
        R_My(randperm(L*time,ceil(pr*L*time)))=randn(ceil(pr*L*time),1);
        Hy=BDH(L,time,R_My);
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