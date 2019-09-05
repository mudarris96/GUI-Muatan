% `clear all;
% cam = serial('com3');
% cam.BaudRate = 115200;
global port;
delete(instrfind);
s = serial(port);
s.BaudRate = 57600;
% cam.BytesAvailableFcnMode = 'terminator';
% cam.BytesAvailableFcn = @instrcallback;
% cam.OutputEmptyFcn = @instrcallback;
% set(cam,'ErrorFcn',@TimeOutErrorFcn)
% cam.inputBufferSize = 100000;
s.Timeout = 1;
fopen(s);
data2 = [];
nnn = 0;
tic
fwrite(s,'0')
% pause(1)
m = 0;
data2=[];
nn = 0;
tic;
while nn == 0
    a = clock;    
    ac = a(6);
    data1=fread(s);
    data2 = [data2 data1'];
%     stat = det_akhir(data1,13);
    a2 = toc;
    if(a2>15)
        tic;
       nn = 1;
    end
% if (stat == 1)
%     break;
% end
    % [msglast, msgidlast] = lastwarn;
    % if strcmp(msglast,'The specified amount of data was not returned within the Timeout period.')
    %     b = clock;
    %     bc = b(6);
    %     sl = bc-ac;
    %     if length(data2)>4000
    %     if sl>10 
    %      nn=1;
    %     end
    %     end
end


fclose(s);
delete(s);
clear s;
% susunDataKamera
p = toc