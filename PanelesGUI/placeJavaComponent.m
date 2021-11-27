function placeJavaComponent ( jcomponent, position, parent )
    jcomponent = javaObjectEDT( jcomponent );  % ensure component is auto-delegated to EDT
    jcomponent.setOpaque(false);  % useful to demonstrate L&F backgrounds
    [jc,hContainer] = javacomponent( jcomponent, [], parent ); %#ok<ASGLU>
    set(hContainer, 'Units','Normalized', 'Position',position);
end  % placeJavaComponen