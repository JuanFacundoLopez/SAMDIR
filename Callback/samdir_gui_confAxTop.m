function samdir_gui_confAxTop(axes)
set(axes,'XColor',[1,1,1], 'YColor',[1,1,1],'Color',[.3,.3,1]);
set(axes, 'XGrid','on', 'YGrid','on', 'YLim',(get(axes,'YLim')*1.2));
end