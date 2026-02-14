function res_H=BDFFGN_TC_SK(L,time,count,theta)
% Time-correlated BD model, for predicting the quantity of S&K, using the change relationship diagram of S&K over time. 
% Input: L base size, time simulation duration, count ensemble repetition times, th0 time correlation index. 
% Output: The original data of the model height, where the last dimension represents the time dimension, allowing for the plotting of the changes of S and K over time.
res_H=zeros(count,L,300);
N0=40;
th0=theta;
ss=(1:N0);Un=6*2.^(-ss);Rn=exp((-Un));
wn=sqrt((12*(1-Rn.^2).*(2^(0.5-th0)-2^(th0-0.5)).*Un.^(1-2*th0))/gamma(2-2*th0));
for cc=1:count    
    h=zeros(1,L+2);
    index_flag=1;
    for pp =1:time
        hh=h;
        zeta=rand(L,N0)-0.5;
        for x=2:L+1
            X1=nan(1,N0);  
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
            h(x)=max([hh(x)+Nrs0,hh(x-1),hh(x+1)]);
        end
        h(1)=h(L+1);
        h(L+2)=h(2);
        if pp~=0 && mod(pp,20)==0
            res_H(cc,:,index_flag)=h(2:L+1);
            index_flag=index_flag+1;
        end
    end    
end