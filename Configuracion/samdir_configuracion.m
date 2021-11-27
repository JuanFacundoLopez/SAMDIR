%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   *
%****************************************************************************************
%* Nombre del Archivo:  samdirAudio.m                                                   *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************

% Este archivo se crea para configurar lo necesario para la GUI 
% antes de que se ejecute la GUI!
addpath([pwd '\Java\funciones']);
addpath([pwd '\Java']);
addpath([pwd '\Callback']);
addpath([pwd '\Utilidades']);
addpath([pwd '\Samdir definitivo']);
addpath([pwd '\imagenes']);
addpath([pwd '\Samdir comunicacion']);
addpath([pwd '\.archivos']);

javaclasspath({pwd '\Java\javalib\SAMDir_GUI.jar',...
               pwd '\Java\AbsoluteLayout.jar', ...
               pwd '\Java\JTattoo.jar', ...
               pwd '\Java\swing-layout-1.0.4.jar', ...
               pwd '\Java\swingx-all-1.6.4.jar', ...
               pwd '\Java\swingx-beaninfo-1.6.4.jar', ...
               pwd '\Java\beansbinding-1.2.1.jar'});
addpath([pwd '\Samdir definitivo']);

promptIn = '';
promptOut = '';
[stat,struc] = fileattrib;
PathCurrent = struc.Name;

FolderName =  '\.archivos';
PathFolder = [PathCurrent FolderName];
NameFileInput = [PathFolder '\input.txt'];
NameFileOutput = [PathFolder '\output.txt'];

% disp = daqhwinfo('winsound');
%  for i = 1:length(disp.BoardNames)
%        
%     promptIn = [promptIn, sprintf(' %2s) %s \n', ...
%                     disp.InstalledBoardIds{i},  disp.BoardNames{i})];
%  end
%  for i = 1:length(disp.BoardNames)
%    promptOut = [promptOut, sprintf(' %2s) %s \n', ...
%                     disp.InstalledBoardIds{i}, disp.BoardNames{i})];
%  end
%  
%  fileIDIn = fopen(NameFileInput,'w');
%  fprintf(fileIDIn,'%6s',promptIn);
%  fclose(fileIDIn);
%  
%  fileIDOut = fopen(NameFileOutput,'w');
%  fprintf(fileIDOut,'%6s',promptOut);
%  fclose(fileIDOut);