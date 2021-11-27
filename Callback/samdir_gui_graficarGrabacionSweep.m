function samdir_gui_graficarGrabacionSweep(axes, grabacion)

   plot(axes, grabacion.timeVector, grabacion.timeData,'c');
   set(axes,'XLim', grabacion.timeVector([1 end]));
end