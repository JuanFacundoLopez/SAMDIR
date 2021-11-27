function [app ventanaAjuste] = samdir_preferencias()

%%% Add dynamic java class path:-  
   % javaclasspath([pwd '\ventanaConfiguracion\javalib\SAMDir_GUI.jar']);
    
%%% Add Matlab path
 %   addpath([pwd '\ventanaConfiguracion\funciones']);

%%% Set default look and feel
    %%% Set default look and feel
 %   javax.swing.UIManager.setLookAndFeel( ...
 %       'com.sun.java.swing.plaf.windows.WindowsLookAndFeel')

%%% invoke the main function
   [app ventanaAjuste] = mainJava();
end