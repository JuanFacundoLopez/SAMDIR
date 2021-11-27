classdef vista < handle
    properties
        mGui
        mModelo
        mControlador
    end
    
    methods
        function obj = vista(controlador)
            obj.mControlador = controlador;
            obj.mModelo = controlador.mModelo;
            obj.mGui = samdirGUI('controlador',obj.mControlador);
            
            addlistener(obj.mModelo,'density','PostSet', ...
                @(src,evnt)vista.handlePropEvents(obj,src,evnt));
            addlistener(obj.mModelo,'volume','PostSet', ...
                @(src,evnt)vista.handlePropEvents(obj,src,evnt));
            addlistener(obj.mModelo,'units','PostSet', ...
                @(src,evnt)vista.handlePropEvents(obj,src,evnt));
            addlistener(obj.mModelo,'mass','PostSet', ...
                @(src,evnt)vista.handlePropEvents(obj,src,evnt));
         end
    end
    
    methods (Static)
        function handlePropEvents(obj,src,evnt)
            evntobj = evnt.AffectedObject;
            handles = guidata(obj.mGui);
            switch src.Name
                case 'density'
                    set(handles.density, 'String', evntobj.density);
                case 'volume'
                    set(handles.volume, 'String', evntobj.volume);
                case 'units'
                    switch evntobj.units
                        case 'english'
                            set(handles.text4, 'String', 'lb/cu.in');
                            set(handles.text5, 'String', 'cu.in');
                            set(handles.text6, 'String', 'lb');
                        case 'si'
                            set(handles.text4, 'String', 'kg/cu.m');
                            set(handles.text5, 'String', 'cu.m');
                            set(handles.text6, 'String', 'kg');
                        otherwise
                            error('unknown units')
                    end
                case 'mass'
                    set(handles.mass,'String',evntobj.mass);
                
            end
        end
    end
end