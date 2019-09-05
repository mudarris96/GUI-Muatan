% amp = [1.0448,0.365,0.0712,0.0622,0.1027]; 
% pha = [77.16,105.75,61.67,320.84,101.95]; 
function kompas_komorindo(pha)
amp = 1;
rdir = pha * pi/180; 
[x,y] = pol2cart(rdir,amp);
compass(x,y)
view([-90 90])