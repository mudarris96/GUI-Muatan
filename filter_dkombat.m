function [data_sensor sisa] = filter_dkombat(out)
data_sensor=[];
nn =find((out(:)==02));
nn1 =find((out(:)==01));
pj = min([length(nn) length(nn1)]);
kk = 0;
for k = 1:pj-1
    if(nn(k)+1==nn1(k))
%         kk = kk+1;
%         valid = 1;
        
        datass= out(nn(k)+2:nn(k+1)-1);
        if (length(datass)==14)
            kk = kk+1;
            data_sensor(kk,:) = datass;
            
        end
        
    else 
         valid =0;
    end
end
sisa = out(nn(pj):end);