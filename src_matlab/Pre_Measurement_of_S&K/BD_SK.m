function res_H=BD_SK(L,time,count)
% Unrelated BD model, predicting the quantity of S&K, using the time variation relationship diagram of S&K. 
% Input: L base size, time simulation time, count ensemble repetition times 
% Output: The original data of the model height, where the last dimension represents the time dimension, allowing for the plotting of the changes of S and K over time.
res_H=zeros(count,L,200);
for cc=1:count
    h=zeros(1,L+2);
    index_flag=1;
    for pp=1:time
        hh=h;
        zeta=randi([0 1],1,L);
        for x=2:L+1
            h(x)=max([hh(x)+zeta(x-1),hh(x-1),hh(x+1)]);
        end
        h(1)=h(L+1);
        h(L+2)=h(2);
        if pp~=0 && mod(pp,30)==0
            res_H(cc,:,index_flag)=h(2:L+1);
            index_flag=index_flag+1;
        end
    end    
end