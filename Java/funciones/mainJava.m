function [app ventanaAjuste] = mainJava() 
% Please use the javaObjectEDT and javaMethodEDT for MATLAB 2010
%
        % Crea los objetos samdir_gui
        app = samdir_gui.config();
        ventanaAjuste = samdir_gui.funcionDeTransf();
        %SetLookAndFeel(app);
        
    %%% Add static trigger button listener
        guardarButton = samdir_gui.botonGuardarCls.getTrigger();
        
  %      buttonProps = handle(guardarButton,'callbackproperties');
   %     set(buttonProps,'ActionPerformedCallback', ...
   %             {@TriggerCallback, app}); 
      %  buttonPropSalir = handle(salirButton,'callbackproperties');
      %  set(buttonPropSalir,'ActionPerformedCallback', ...
      %          {@SalirCallback, app}); 
        

end