%> @ingroup guigroup
%> @file
%> @brief Properties Window for Cross-calculation Analysis Session
%> @sa as_crossc
%> @cond
function varargout = uip_as_crossc(varargin)
% Last Modified by GUIDE v2.5 14-Nov-2012 11:28:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @uip_as_crossc_OpeningFcn, ...
                   'gui_OutputFcn',  @uip_as_crossc_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before uip_as_crossc is made visible.
function uip_as_crossc_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output.flag_ok = 0;
guidata(hObject, handles);
gui_set_position(hObject);
refresh(handles);

% --- Outputs from this function are returned to the command clae.
function varargout = uip_as_crossc_OutputFcn(hObject, eventdata, handles) 
try
    uiwait(handles.figure1);
    handles = guidata(hObject);
    varargout{1} = handles.output;
    delete(gcf);
catch %#ok<*CTCH>
    output.flag_ok = 0;
    output.params = {};
    varargout{1} = output;
end;

%-------------------------------------------------------------------------------------------------------------------------------------------

%#####
function refresh(handles)
listbox_load_from_workspace({'fcon_linear', 'block_cascade_base'}, handles.popupmenu_mold, 0);
listbox_load_from_workspace('sgs', handles.popupmenu_sgs, 1);

%-------------------------------------------------------------------------------------------------------------------------------------------

%#####
function pushbuttonOK_Callback(hObject, eventdata, handles) %#ok<*INUSL>
try
    smold = listbox_get_selected_1stname(handles.popupmenu_mold);
    if isempty(smold)
        irerror('Mold Block not specified!');
    end;
    ssgs = listbox_get_selected_1stname(handles.popupmenu_sgs);
    if isempty(ssgs)
        ssgs = '[]';
    end;

    handles.output.params = {...
    'mold', smold, ...
    'sgs', ssgs, ...
    };
    handles.output.flag_ok = 1;
    guidata(hObject, handles);
    uiresume();
catch ME
    irerrordlg(ME.message, 'Cannot continue');
end;

%-------------------------------------------------------------------------------------------------------------------------------------------

function popupmenu_sgs_Callback(hObject, eventdata, handles)
function popupmenu_sgs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function popupmenu_mold_Callback(hObject, eventdata, handles)
function popupmenu_mold_CreateFcn(hObject, eventdata, handles) %#ok<*INUSD,*DEFNU>
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%> @endcond
