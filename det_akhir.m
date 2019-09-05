%Deteksi akhir data stream data gambar dari muatan
function stat = det_akhir(data,kode)  %data dalam bentuk hexa
% dat = hex2dec(data)
n = length(data);
for k = 1: n
    if(data(k) == kode)
        stat = 1;
        break;
    else
        stat = 0;
    end
end
