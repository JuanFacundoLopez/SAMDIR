function samdir_gui_graficarIRmasVentana(axes, ir_mod, ventana)

   plot(axes,ir_mod.timeVector,ir_mod.timeData,'c',ventana.timeVector,ventana.timeData,'--r','LineWidth',1.5);
   samdir_gui_confAxTop(axes);
   set(axes,'XLim', ir_mod.timeVector([1 end]));
   set(axes,'YLim', [-1.2 1.2]);
   set(get(axes,'XLabel'),'String','seg.');
   set(get(axes,'YLabel'),'String','Amplitud');
   set(get(axes,'Title'),'String',ir_mod.comment, 'Color','w', 'FontWeigh', 'bold' );
end