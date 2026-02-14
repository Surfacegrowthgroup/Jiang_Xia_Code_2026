function res=sta_micRSOS_strc(data)
%This code is used to calculate the statistical distribution of various short-range microscopic structures in the surface morphology of the RSOS model. 
% Input: The original height data of different ensembles at a certain moment for the dataRSOS model. 
% Output: The proportion of each microstructure in the total microstructure.

num_xxx=zeros(9,1);
%str_r=["num_000","num_100","num_010","num_001","num_110","num_011","num_101","num_210","num_012"
res=zeros(9,1);
sz=size(data);
line=zeros(1,sz(1,2)+2);
for i=1:sz(1,1)
    line(1,2:sz(1,2)+1)=data(i,:);
    line(1,1)=line(1,sz(1,2)+1);
    line(1,sz(1,2)+2)=line(1,2);
    for j=1:sz(1,2)
        j=j+1;
        zx1=min_o_f(line(j-1),line(j),line(j+1));
        box=line(j-1:j+1)-zx1;
        switch sum(box)
            case 0
                num_xxx(1)=num_xxx(1)+1;
            case 1
                if line(j-1)>line(j)
                    num_xxx(2)=num_xxx(2)+1;
                elseif line(j)>line(j+1)
                    num_xxx(3)=num_xxx(3)+1;
                else
                    num_xxx(4)=num_xxx(4)+1;
                end
            case 2
                if line(j)==line(j-1)
                    num_xxx(5)=num_xxx(5)+1;
                elseif line(j)==line(j+1)
                    num_xxx(6)=num_xxx(6)+1;
                else
                    num_xxx(7)=num_xxx(7)+1;
                end
            case 3
                if line(j-1)>line(j)
                    num_xxx(8)=num_xxx(8)+1;
                else
                    num_xxx(9)=num_xxx(9)+1;
                end
        end
    end
end
fac=sum(num_xxx);
for i=1:9
    res(i)=num_xxx(i)/fac;
end
end

function zx=min_o_f(a,b,c)
zx=a;
if(b<zx)
    zx=b;
end
if(c<zx)
    zx=c;
end
end