baca_kamera_sensorok;   % akses port, request data gambar ke muatan
gbr = ambilRawPic(data2); %filter data gambar file JPG dimulai FF D8 diakhiri dengan FF D9
susunDataKamera;          %susun ulang file array baris file jpg menjadi bentuk matrik ukuran nx122 kemudian diplot ke akses     