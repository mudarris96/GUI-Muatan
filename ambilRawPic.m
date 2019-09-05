function gbr = ambilRawPic(dat)
kode1a = hex2dec('FF');
kode1b = hex2dec('D8');
kode2a = hex2dec('FF');
kode2b = hex2dec('D9');
gg = dat;
n = length(dat);
for k = 1: n-1
    if(gg(k)== kode1a)&&(gg(k+1)==kode1b)
        a1 = k;
    elseif (gg(k)== kode2a)&&(gg(k+1)==kode2b)
        a2 = k;
        gbr = dat(a1:a2+1);
    end
end
        
