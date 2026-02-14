function res_H=BDFFGN_SC_SK(L,time,count,th0)
% Spatial correlation BD model, for predicting the quantity of S&K, using the time variation relationship diagram of S&K. 
% Input: L base size, time simulation time, count ensemble repetition times, th0 spatial correlation index. 
% Output: The original data of the model height, where the last dimension represents the time dimension, allowing for the plotting of the changes of S and K over time.
res_H=zeros(count,L,300);
N0=40;
ss=(1:N0);Un=6*2.^(-ss);Rn=exp((-Un));
wn=sqrt((12*(1-Rn.^2).*(2^(0.5-th0)-2^(th0-0.5)).*Un.^(1-2*th0))/gamma(2-2*th0));
for cc=1:count    
    h=zeros(1,L+2);
    index_flag=1;
    R_M=rand(time,N0,L);
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
    for pp=1:time
        hh=h;
        noz1=noz(:,pp);
        for x=2:L+1   
            h(x)=max([hh(x)+noz1(x-1),hh(x-1),hh(x+1)]);
        end
        h(1)=h(L+1);
        h(L+2)=h(2);
        if pp~=0 && mod(pp,5)==0
            res_H(cc,:,index_flag)=h(2:L+1);
            index_flag=index_flag+1;
        end
    end    
end