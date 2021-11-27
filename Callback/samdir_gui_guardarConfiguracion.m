function samdir_gui_guardarConfiguracion(ventanaConfiguracion)

 hashMap = ventanaConfiguracion.ReadObject();
 data = Hash2Struct(hashMap);
 set_preferencias(data);
 clc
 set_preferencias('nChannels', 1);
 devIn = set_preferencias('inputDeviceName');
 devOut = set_preferencias('outputDeviceName');
 disp = daqhwinfo('winsound');

 for i = 1:length(disp.BoardNames)
     promptIn = sprintf(' %2s) %s \n', ...
                       disp.InstalledBoardIds{i},  disp.BoardNames{i});   
     if strncmp(promptIn,devIn, 4)

         set_preferencias('inputDeviceID', str2num(disp.InstalledBoardIds{i}));
     end
 end
 for i = 1:length(disp.BoardNames)
     promptOut = sprintf(' %2s) %s \n', ...
                        disp.InstalledBoardIds{i},  disp.BoardNames{i});
     if strncmp(promptOut,devOut,4)
         set_preferencias('outputDeviceID', str2num(disp.InstalledBoardIds{i}));
     end
 end

end