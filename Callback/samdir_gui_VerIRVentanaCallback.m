function samdir_gui_VerIRVentanaCallback(ir_mod, vent)

figure;
plot(ir_mod.timeVector,ir_mod.timeData,'k',vent.timeVector,vent.timeData,'--r','LineWidth',1.5);
title(ir_mod.comment);
grid on
yLimits = get(gca,'YLim');
yLim([(yLimits(1)*1.2) (yLimits(2)*1.2)]);
end