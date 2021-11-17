function [Xpix,Ypix,FrameRate]=findkeyparams_newThor()

%use this function to get the FOV and the framerate of aquisition 
%you have to parse the XML file from thor. 
%this sucks and is definitely not elegent 

disp('Show me where the XML file is for any experiment from this set');
[matexpfile,matexppath]=uigetfile('*.*');
cd(matexppath);
xmlexp=parseXML('Experiment.xml');
kids=xmlexp.Children;
FrameRate=kids(26).Attributes(23).Value; %LSM variable, attribute 11 is framerate
Xpix=kids(26).Attributes(36).Value;%hardcoded because I'm not good at this
Ypix=kids(26).Attributes(37).Value;
Xpix=str2double(Xpix);
Ypix=str2double(Ypix);


end