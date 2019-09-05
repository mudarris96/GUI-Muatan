function [data_sensor sisa] = filter_dkomorindo(out)
data_sensor=[];
nn =find((out(:)==2));
nn1 =find((out(:)==2019));
pj = min([length(nn) length(nn1)]);
kk = 0;
for k = 1:pj-1
    if(nn(k)+1==nn1(k))
        
       
%         data_sensor(kk,:)= out(nn(k)+2:nn(k+1)-1);
        dss = out(nn(k)+2:nn(k+1)-1);
        if (length(dss)==9)
            valid = 1;
            kk = kk+1;
            data_sensor(kk,:)= dss;
        end
    else 
         valid =0;
    end
end
sisa = out(nn(pj):end);

%Error dengan panjang DW tidak sama dengan panjang variabel lain
% Data sensor pada baris 13 terlihat aneh kenapa data_sensor = []? apa
% kejadian yang pernah terjadi sehingga skrip ini muncul?