d1 = data2;
n = length(d1);
for k = 1: n-1
    if (data2(k)==hex2dec('FF'))|(data2(k+1)==hex2dec('D8'))
        a1 = k;
    elseif ((data2(k)==hex2dec('FF'))|(data2(k+1)==hex2dec('D9')))
        a2 = k;
    end
end
data_gbr = data2(a1:a2);
nn = length(data_gbr);
ii = 0;
data = [];
na = mod(nn,122);
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
axes(handles.axes1)
set(f,'renderer','openGL');
imshow('gambar30.jpg');
