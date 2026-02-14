function res_H=RSOSFFGN_TC_SK(L,time,count,th0,s)
% Time-correlated RSOS model, for predicting the quantity of S&K, using the change relationship diagram of S&K over time. 
% Input: L base size, time simulation time, count number of ensemble repetitions, th0 time correlation index, s is the upper limit of the nearest height difference (all are constant 1). 
% Output: The original data of the model height, where the last dimension represents the time dimension, allowing for the plotting of the changes of S and K over time.
N0=40;
ss=(1:N0);Un=6*2.^(-ss);Rn=exp((-Un));
wn=sqrt((12*(1-Rn.^2).*(2^(0.5-th0)-2^(th0-0.5)).*Un.^(1-2*th0))/gamma(2-2*th0));
res_H=zeros(count,L,200);
for cc=1:count
    h=zeros(1,L+2);
    flag=1;
    for pp=1:time
        hh=h;
        zeta=rand(L,N0)-0.5;
        for x=2:L+1
            if pp==1                
                  X1=power((1-power(Rn,2)),-1/2).*zeta(x-1,:);              
            else                
                  X1=Rn.*X0(x-1,:)+zeta(x-1,:);                
            end           
            X0(x-1,:)=X1(1,:);                      
            Rs0=wn*(X1.');            
            if Rs0>0
                Nrs0=1;
            else
                Nrs0=0;
            end
            if abs(hh(x)+1-hh(x-1))<=s && abs(hh(x)+1-hh(x+1))<=s
                h(x)=hh(x)+Nrs0;
            end
        end
        h(1)=h(L+1);
        h(L+2)=h(2);
        if pp~=0 && mod(pp,15)==0
            res_H(cc,:,flag)=-h(2:L+1);
            flag=flag+1;
        end
    end
end