loopi = 0;
while loopi == 0
baca_kamera_sensorok2;   % akses port, request data gambar ke muatan
gbr = ambilRawPic2(data2) %filter data gambar file JPG dimulai FF D8 diakhiri dengan FF D9
if isempty(gbr)
    loopi = 0;
else
    loopi = 1;
    susunDataKamera; 
end
   
end%susun ulang file array baris file jpg menjadi bentuk matrik ukuran nx122 kemudian diplot ke akses   
