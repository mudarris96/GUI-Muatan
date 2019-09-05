global port
delete(instrfind)
ix = get(handles.DAFTAR_COM,'value');
s = serial (port(ix));      % membuat objek atau membuat varibael untuk akses port com 4
s.InputBufferSize = 600;
% s.BaudRate = 9600;
s.BaudRate = 57600;
% out1 = instrfind('Port','COM14')
% out1 = instrfind('Port',port(ix))
% fclose(out1)
fopen(s)