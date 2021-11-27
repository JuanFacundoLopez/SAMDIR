function ObtenerCallback(h,e, GUI)
    
    samdir_logMensajes(GUI.jLogPanel, 'Obtener FT ...');
    a = samdir_generate('expsweep',[2 22000],44100,15);
    b = samdir_medicion_ir(a, GUI.jLogPanel);
    b.play;
end