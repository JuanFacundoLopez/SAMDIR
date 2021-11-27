function samdir_gui_VerIRCallback(ir_vent)

figure;

plot(ir_vent.timeVector,ir_vent.timeData,'k');
title(ir_vent.comment);
grid on
yLimits = get(gca,'YLim');
yLim([(yLimits(1)*1.2) (yLimits(2)*1.2)]);
end