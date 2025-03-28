function varargout = RecipeGUI(varargin)
% RECIPEGUI MATLAB code for RecipeGUI.fig
%      RECIPEGUI, by itself, creates a new RECIPEGUI or raises the existing
%      singleton*.
%
%      H = RECIPEGUI returns the handle to a new RECIPEGUI or the handle to
%      the existing singleton*.
%
%      RECIPEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECIPEGUI.M with the given input arguments.
%
%      RECIPEGUI('Property','Value',...) creates a new RECIPEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RecipeGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RecipeGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Last Modified by GUIDE v2.5 09-Jul-2014 16:41:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
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


% --- Executes just before RecipeGUI is made visible.
function RecipeGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure

% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RecipeGUI (see VARARGIN)

% Choose default command line output for RecipeGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Load CSS styles
web(['file:///' fullfile(pwd, 'assets', 'styles', 'MITPE_Style.css')]);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using RecipeGUI.
if strcmp(get(hObject,'Visible'),'off')
   %seematrix(data.DSM)
end

% UIWAIT makes RecipeGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RecipeGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure

% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%--------------------------------------------------------------%
% DSM controls
%--------------------------------------------------------------%
%-----------------------------%
% Update DSM button
%-----------------------------%
function updateDSMbutton_CreateFcn(hObject, eventdata, handles)
% Executes during object creation, after setting all properties.

% handles    empty - handles not created until after all CreateFcns called


function updateDSMbutton_Callback(hObject, eventdata, handles)
% Executes on pressing 'Update DSM' button.
data = guidata(gcbo);

% Initialize new DSM.
data.method
data.DSM = init_DSM(data.n,data.d,data.method);
guidata(gcbo,data);

% Display new DSM.
axes(data.DSMaxes);
cla;
seematrix(data.DSM)
xlabel('Modifying component')
ylabel('Dependent component')


%popup_sel_index = get(handles.DSMdropdown, 'Value');
% switch popup_sel_index
%     case 1
%         plot(rand(5));
%     case 2
%         plot(sin(1:0.01:25.99));
%     case 3
%         bar(1:.5:10);
%     case 4
%         plot(membrane);
%     case 5
%         surf(peaks);
% end


%-----------------------------%
% DSM method dropdown menu
%-----------------------------%
function DSMdropdown_CreateFcn(hObject, eventdata, handles)
% Executes during object creation, after setting all properties.

% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'fixed out-degree', 'fixed in-degree', 'random'});


function DSMdropdown_Callback(hObject, eventdata, handles)
% Executes on selection change in DSMdropdown.

% Hints: contents = get(hObject,'String') returns DSMdropdown contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DSMdropdown
data = guidata(gcbo);

dropdown_contents  = get(hObject,'String');
dropdown_selection = dropdown_contents( get(hObject,'Value') );
switch dropdown_selection{1}
end
guidata(gcbo,data);

%-----------------------------%
% DSM axes
%-----------------------------%
function DSMaxes_CreateFcn(hObject, eventdata, handles)
% Executes during object creation, after setting all properties.

% handles    empty - handles not created until after all CreateFcns called