function varargout = GUI2018(varargin)
% GUI2018 MATLAB code for GUI2018.fig
%      GUI2018, by itself, creates a new GUI2018 or raises the existing
%      singleton*.
%
%      H = GUI2018 returns the handle to a new GUI2018 or the handle to
%      the existing singleton*.
%
%      GUI2018('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI2018.M with the given input arguments.
%
%      GUI2018('Property','Value',...) creates a new GUI2018 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI2018_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      exit.  All inputs are passed to GUI2018_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI2018

% Last Modified by GUIDE v2.5 19-Aug-2019 09:31:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI2018_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI2018_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI2018 is made visible.
function GUI2018_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI2018 (see VARARGIN)

% Choose default command line output for GUI2018
handles.output = hObject;
hback = axes('units','normalized','position',[0 0 1 1]);
uistack(hback,'bottom');
[back map]=imread('pinisi.jpg');
image(back)
colormap(map)

setappdata(0,'utama',gcf)
setappdata(gcf,'nn',0)

% set(hback,'handlevisibility','off','visible','off');
% Update handles structure
guidata(hObject, handles);



% UIWAIT makes GUI2018 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI2018_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in START.
function START_Callback(hObject, eventdata, handles)
% hObject    handle to START (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
utama = getappdata(0,'utama');
setappdata(utama,'nn',0);
global dataa1;
% global port
% delete(instrfind)
% ix = get(handles.DAFTAR_COM,'value');
% s = serial (port(ix));      % membuat objek atau membuat varibael untuk akses port com 4
% s.InputBufferSize = 600;
% % s.BaudRate = 9600;
% s.BaudRate = 57600;
% % out1 = instrfind('Port','COM14')
% % out1 = instrfind('Port',port(ix))
% % fclose(out1)
% fopen(s)
aktifasiport;
tandak = 0;
DGLat = [];
DGLong = [];
DAX = [];
DAY = [];
DAZ = [];
DGX = [];
DGY = [];
DGZ = [];
DT = [];
DP = [];
DAT = [];
DK = [];
b = [];
datasensor=[];
sudut1 = 0;
sudut2 = 0;
sudut3 = 0;
sisa = [];
datas = [];
datanum = [];
dataal = [];
% latar=imread('kompas.jpg');
% axes(handles.axes11);
% imshow(latar);
tic;
axes(handles.axes4);
plot3([3 3],[5 7], [6 6],'linewidth',6)%ekor
hold on
plot3([6 6],[3 9], [6 6],'linewidth',6)%sayap
plot3([3 10],[6 6], [6 6],'linewidth',10)%poros
grid on
po= [ 6 6 6];
poros = [3 6 6;10 6 6];
sayap = [6 3 6;6 9 6];
ekor = [3 5 6;3 7 6];
center = [6 6 6];
ss1 = 1+ones(1,75);
ssy = 1:0.1:30;
ssy = ssy(1:75);
ssz = 1.2+(rand(1,75)/10);
data_gerak =[ss1' ssy' ssz']; 
kn = 0;                  
axes(handles.axes4)
cla
a1 = clock;
while tandak == 0;
    utama = getappdata(0,'utama');
    nn = getappdata(utama,'nn');
    if nn ==1
       tandak = 1;
    end
%     pause(0.1);
data = fread(s);
if (length(data)>400)
% datasensor=char(data(:)');

% [nama data sisa] = filter_data_komor(datasensor);
out=char(data(:)');
datas=str2double(regexp(out,'[\d.\-]+','match')); %pemisahan data numerik dan  alphanumerik
if ~isempty(sisa)
 datas=[sisa datas];
end
try
[datasensor sisa] = filter_dkombat(datas);
catch me
    if (strcmp(me.identifier,'MATLAB:subsassigndimmismatch'))
        msg = ['Subscripted assignment dimension mismatch.']
%        me = addCause(me,causeException);
    end
%     rethrow(me)
end
% if ~isempty(sisa)
% datasensor=[sisa datasensor]
% end
% [kode datanum sisa] = filter_data_komorindo(datasensor);
if ~isempty(datasensor)
    
DGLat = [datasensor(:,1); DGLat];    %latitude
DGLong = [datasensor(:,2); DGLong];  %longitude
DAX = [datasensor(:,3); DAX];        %accelerox
DAY = [datasensor(:,4); DAY];        %acceleroy
DAZ = [datasensor(:,5); DAZ];        %acceleroz
DGX = [datasensor(:,6); DGX];        %gyrox
DGY = [datasensor(:,7); DGY];       %gyroy
DGZ = [datasensor(:,8); DGZ];       %gyroz
DT = [datasensor(:,9); DT];         %ketinggian
DP = [datasensor(:,10); DP];         %tekanan
DAT = [datasensor(:,11); DAT];       %altitue
DK = [datasensor(:,12); DK];         %kompas
dataal = [datasensor; dataal];

ghh = num2str(dataal);
set(handles.LISTDATA,'string',ghh)
aacw = toc;
% if aacw> 15000
% %   vid = videoinput('winvideo')
% %   set(vid,'ReturnedColorSpace','rgb');
% %   a = getsnapshot(vid);
% %   axes(handles.axes13);
% %   imshow(a);
%   tic;
% end
set(handles.TXACC,'string',num2str([DAX(1) DAY(1) DAZ(1)]));
set(handles.TXGY,'string',num2str([DGX(1) DGY(1) DGZ(1)]));
set(handles.TXLON,'string',num2str(DGLong(1)));
set(handles.TXLAT,'string',num2str(DGLat(1)));
set(handles.TXKOM,'string',num2str(DK(1)));
set(handles.TXTEM,'string',num2str(DT(1)));

axes(handles.axes7)
kompas_komorindo(DK(1))
axes(handles.axes3)
mapp = imread('C1.jpg');
imshow(mapp);
axes(handles.axes1)

if (length(DAX)<100)
    plot(1:length(DAX),DAX,'r',1:length(DAY),DAY,'g',1:length(DAZ),DAZ,'b','linewidth',2)
% axis([0 100 -6000 18000])
else
    try
    plot(0:100,DAX(1:101),'r',0:100,DAY(1:101),'g',0:100,DAZ(1:101),'b','linewidth',2)
    catch err
        pesan = 'data kurang baik';
    end
end
    grid on;
    data_acc = [DAX DAY DAZ DGX DGY DGZ];
% posisi_roket(data_acc);

% sudut1 = sudut1+5;
% if sudut1>90
%     sudut1 = 90;
%     kn = kn +1;
% axes(handles.axes7)
% % plot3(data_gerak(1:kn,1),data_gerak(1:kn,2),data_gerak(1:kn,3),'linewidth',3)
% grid on
% axis([0 15 0 10 0 10])
% if kn>75
%     kn = 75;
% end
% 
% end
% axes(handles.axes4)
% perpindahan(ekor,poros,sayap,center,sudut1)
% 

% axes(handles.axes15);
% cla
% plot3([3 10],[6 6], [6 6],'linewidth',10)%poros
% grid on
% center = [6 6 6];
% [xbe ybe zbe xbp ybp zbp]= perpindahan(ekor,poros,center,DGY(1))
% ekor = [xbe ybe zbe];
% sayap = [xbp ybp zbp];
% [xbe ybe zbe xbp ybp zbp]= roll(ekor,sayap,center,DGX(1))
% ekor = [xbe ybe zbe];
% sayap = [xbp ybp zbp];
%%%24/8:3:54 tambahan
a2 = toc; %mengambil waktu dalam detik

if (a2>100) % selama selang 150 detik data gambar diambil
    tic;
    try
    kameraMuatan2   %subprogram baru ditambahkan
    aktifasiport;
    catch err
        pesan ='Data Gambar tidak Valid';
    end
end
%%%24/8:3:54 tambahan

pause(0.1);
end
end
end
% save('datamuatan2019','dataal')
save('datamuatan2019')
% fclose(s);
% delete(s);
% clear s;


% --- Executes on button press in PAUSE.
function PAUSE_Callback(hObject, eventdata, handles)
% hObject    handle to PAUSE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
utama = getappdata(0,'utama');
setappdata(utama,'nn',1);

% --- Executes on button press in EXIT.
function EXIT_Callback(hObject, eventdata, handles)
% hObject    handle to EXIT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);


% --- Executes on button press in SIMPAN.
function SIMPAN_Callback(hObject, eventdata, handles)
% hObject    handle to SIMPAN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global dataa1;
save('datamuatan2019','dataa1');
% --- Executes on selection change in DAFTAR_COM.
function DAFTAR_COM_Callback(hObject, eventdata, handles)
% hObject    handle to DAFTAR_COM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DAFTAR_COM contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DAFTAR_COM


% --- Executes during object creation, after setting all properties.
function DAFTAR_COM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DAFTAR_COM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in WAKTU.
function WAKTU_Callback(hObject, eventdata, handles)
% hObject    handle to WAKTU (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns WAKTU contents as cell array
%        contents{get(hObject,'Value')} returns selected item from WAKTU


% --- Executes during object creation, after setting all properties.
function WAKTU_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WAKTU (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PITCH_Callback(hObject, eventdata, handles)
% hObject    handle to PITCH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PITCH as text
%        str2double(get(hObject,'String')) returns contents of PITCH as a double


% --- Executes during object creation, after setting all properties.
function PITCH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PITCH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ROLL_Callback(hObject, eventdata, handles)
% hObject    handle to ROLL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ROLL as text
%        str2double(get(hObject,'String')) returns contents of ROLL as a double


% --- Executes during object creation, after setting all properties.
function ROLL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ROLL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function YAW_Callback(hObject, eventdata, handles)
% hObject    handle to YAW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of YAW as text
%        str2double(get(hObject,'String')) returns contents of YAW as a double


% --- Executes during object creation, after setting all properties.
function YAW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YAW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TXPT_Callback(hObject, eventdata, handles)
% hObject    handle to TXPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXPT as text
%        str2double(get(hObject,'String')) returns contents of TXPT as a double


% --- Executes during object creation, after setting all properties.
function TXPT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TXRL_Callback(hObject, eventdata, handles)
% hObject    handle to TXRL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXRL as text
%        str2double(get(hObject,'String')) returns contents of TXRL as a double


% --- Executes during object creation, after setting all properties.
function TXRL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXRL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TXYW_Callback(hObject, eventdata, handles)
% hObject    handle to TXYW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXYW as text
%        str2double(get(hObject,'String')) returns contents of TXYW as a double


% --- Executes during object creation, after setting all properties.
function TXYW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXYW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in LISTDATA.
function LISTDATA_Callback(hObject, eventdata, handles)
% hObject    handle to LISTDATA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns LISTDATA contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LISTDATA


% --- Executes during object creation, after setting all properties.
function LISTDATA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LISTDATA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ACCELERO_Callback(hObject, eventdata, handles)
% hObject    handle to ACCELERO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ACCELERO as text
%        str2double(get(hObject,'String')) returns contents of ACCELERO as a double


% --- Executes during object creation, after setting all properties.
function ACCELERO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ACCELERO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GYROSCOPE_Callback(hObject, eventdata, handles)
% hObject    handle to GYROSCOPE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GYROSCOPE as text
%        str2double(get(hObject,'String')) returns contents of GYROSCOPE as a double


% --- Executes during object creation, after setting all properties.
function GYROSCOPE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GYROSCOPE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function APOGEE_Callback(hObject, eventdata, handles)
% hObject    handle to APOGEE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of APOGEE as text
%        str2double(get(hObject,'String')) returns contents of APOGEE as a double


% --- Executes during object creation, after setting all properties.
function APOGEE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to APOGEE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TXACC_Callback(hObject, eventdata, handles)
% hObject    handle to TXACC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXACC as text
%        str2double(get(hObject,'String')) returns contents of TXACC as a double


% --- Executes during object creation, after setting all properties.
function TXACC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXACC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TXGY_Callback(hObject, eventdata, handles)
% hObject    handle to TXGY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXGY as text
%        str2double(get(hObject,'String')) returns contents of TXGY as a double


% --- Executes during object creation, after setting all properties.
function TXGY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXGY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TXAP_Callback(hObject, eventdata, handles)
% hObject    handle to TXAP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXAP as text
%        str2double(get(hObject,'String')) returns contents of TXAP as a double


% --- Executes during object creation, after setting all properties.
function TXAP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXAP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function KECEPATAN_Callback(hObject, eventdata, handles)
% hObject    handle to KECEPATAN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KECEPATAN as text
%        str2double(get(hObject,'String')) returns contents of KECEPATAN as a double


% --- Executes during object creation, after setting all properties.
function KECEPATAN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KECEPATAN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TEMPERATURE_Callback(hObject, eventdata, handles)
% hObject    handle to TEMPERATURE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TEMPERATURE as text
%        str2double(get(hObject,'String')) returns contents of TEMPERATURE as a double


% --- Executes during object creation, after setting all properties.
function TEMPERATURE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TEMPERATURE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function KOMPAS_Callback(hObject, eventdata, handles)
% hObject    handle to KOMPAS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KOMPAS as text
%        str2double(get(hObject,'String')) returns contents of KOMPAS as a double


% --- Executes during object creation, after setting all properties.
function KOMPAS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KOMPAS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TXKEC_Callback(hObject, eventdata, handles)
% hObject    handle to TXKEC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXKEC as text
%        str2double(get(hObject,'String')) returns contents of TXKEC as a double


% --- Executes during object creation, after setting all properties.
function TXKEC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXKEC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TXTEM_Callback(hObject, eventdata, handles)
% hObject    handle to TXTEM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXTEM as text
%        str2double(get(hObject,'String')) returns contents of TXTEM as a double


% --- Executes during object creation, after setting all properties.
function TXTEM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXTEM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TXKOM_Callback(hObject, eventdata, handles)
% hObject    handle to TXKOM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXKOM as text
%        str2double(get(hObject,'String')) returns contents of TXKOM as a double


% --- Executes during object creation, after setting all properties.
function TXKOM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXKOM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LONGITUDE_Callback(hObject, eventdata, handles)
% hObject    handle to LONGITUDE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LONGITUDE as text
%        str2double(get(hObject,'String')) returns contents of LONGITUDE as a double


% --- Executes during object creation, after setting all properties.
function LONGITUDE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LONGITUDE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LATITUDE_Callback(hObject, eventdata, handles)
% hObject    handle to LATITUDE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LATITUDE as text
%        str2double(get(hObject,'String')) returns contents of LATITUDE as a double


% --- Executes during object creation, after setting all properties.
function LATITUDE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LATITUDE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TXLON_Callback(hObject, eventdata, handles)
% hObject    handle to TXLON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXLON as text
%        str2double(get(hObject,'String')) returns contents of TXLON as a double


% --- Executes during object creation, after setting all properties.
function TXLON_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXLON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TXLAT_Callback(hObject, eventdata, handles)
% hObject    handle to TXLAT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXLAT as text
%        str2double(get(hObject,'String')) returns contents of TXLAT as a double


% --- Executes during object creation, after setting all properties.
function TXLAT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXLAT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DCOM.
function DCOM_Callback(hObject, eventdata, handles)
% hObject    handle to DCOM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global port;
port = seriallist;
n = length(port)
if n>0
set(handles.DAFTAR_COM,'string',port)
end
