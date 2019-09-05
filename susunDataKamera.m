d1 = gbr;
n = length(d1);
ii = 0;
data = [];
na = mod(n,122);
if na ~= 0
    lk = 1;
else
    lk = 0;
end
for k = 0: 122:n
    ii = ii+1;
    nn = 1:122;
    if ii > floor(n/122);
    if lk ~= 0 
      nn = 1:na;
    end
    end
        data(ii,nn) = d1(k+nn)';
%     data(ii,:) = hex2dec(char(d1(k+1:k+128)'));
end
gmbr=fopen('gambar30.jpg','w+');
% data = Img_data_packet(1:t,5:126);
[p l] = size(data);
for k = 1:p
    data_g = data(k,:);
    fwrite(gmbr,data_g);
end
fclose(gmbr);
f=handles.figure1;
axes(handles.axes6)
set(f,'renderer','openGL');
try
imshow('gambar30.jpg');
catch err
    pesan = 'gambarnya cacat'
end