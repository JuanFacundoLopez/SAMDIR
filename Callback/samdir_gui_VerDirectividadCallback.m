function samdir_gui_VerDirectividadCallback(h,e, GUI)
% global octava_ent
%     ventana = getappdata(0,'VentanaDirectividad');
%     rho   = getappdata(0, 'rho');
%     theta = getappdata(0, 'theta');
%     parametrs = getappdata(0, 'params');
    GUI.handles.controller.verDirectividadLupa();
%     if(ventana == 1)
%         
%         graficarDiagrama(1, 4, theta, rho, parametrs, octava_ent, ventana);
%         drawnow;
%     elseif (ventana == 2)
%         
%         graficarDiagrama(5, 7, theta, rho, parametrs, octava_ent, ventana);
%         drawnow;
%     elseif (ventana == 3)
%         
%         graficarDiagrama(8, 10, theta, rho, parametrs, octava_ent, ventana);
%         drawnow;
%     end
end

function graficarDiagrama(inicio, fin, theta, rho, parameters,leyenda, ventana)
    
    vectorColor = ['c', 'r', 'm', 'g', 'c', 'r', 'm', 'c', 'r', 'm'];
     figure;
     hold off
    nLeyenda = 0;
    for i=inicio:fin,
         nLeyenda = nLeyenda + 1;
         dirplot(theta',rho(:,i), vectorColor(i), parameters);
         hold on
         
         %legend([int2str(frec),'Hz'],-1);  %Incorporarlo para todas las
         %Frec
    end
    switch ventana
        case 1
            legend(leyenda{1},leyenda{2},leyenda{3}, leyenda{4}, -1);
            titulo = 'Diagrama de Directividad - Frecuencias Bajas';
        case 2
            legend(leyenda{5},leyenda{6},leyenda{7}, -1);
            titulo = 'Diagrama de Directividad - Frecuencias Medias';
        case 3
            legend(leyenda{8},leyenda{9},leyenda{10}, -1);%'Position',[0.39,0.45,0.25,0.1]
            titulo = 'Diagrama de Directividad - Frecuencias Altas';
    end
    title(titulo);
   
end