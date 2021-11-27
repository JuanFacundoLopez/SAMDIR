function samdir_gui_graficarIRVentaneada(axes, ir_vent)

   plot(axes,ir_vent.timeVector,ir_vent.timeData,'c');
   samdir_gui_confAxTop(axes);
   set(axes,'XLim', ir_vent.timeVector([1 end]));
   set(axes,'YLim', [-1.2 1.2]);
   set(get(axes,'XLabel'),'String','seg.');
   set(get(axes,'YLabel'),'String','Amplitud');
   set(get(axes,'Title'),'String',ir_vent.comment, 'Color','w', 'FontWeigh', 'bold' );
end