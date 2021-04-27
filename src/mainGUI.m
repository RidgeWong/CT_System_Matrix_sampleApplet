function varargout = mainGUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @mainGUI_OpeningFcn, ...
    'gui_OutputFcn',  @mainGUI_OutputFcn, ...
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

function mainGUI_OpeningFcn(hObject, ~, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);


function varargout = mainGUI_OutputFcn(~, ~, handles)
varargout{1} = handles.output;

%============================================================%
% proj axes
function projAxes_CreateFcn(hObject, ~, ~)
projAxesInitialize(hObject);

%============================================================%
% proj angle static text
function projAngle_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function projAngle_Callback(~, ~, ~)
function projAngle_ButtonDownFcn(hObject, ~, ~)
set(hObject, 'String', '', 'Enable', 'on', 'ForegroundColor', [0 0 0]);
uicontrol(hObject);
function projAngle_KeyPressFcn(~, ~, ~)

%============================================================%
% detector index static text
function detectorIndex_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function detectorIndex_Callback(~, ~, ~)
function detectorIndex_ButtonDownFcn(hObject, ~, ~)
set(hObject, 'String', '', 'Enable', 'on', 'ForegroundColor', [0 0 0]);
uicontrol(hObject);
function detectorIndex_KeyPressFcn(~, ~, ~)

%============================================================%
% draw proj line button
function drawProjLineButton_Callback(~, ~, handles)
axes(handles.projAxes) ;
cla reset;
projAxesInitialize(handles.projAxes);
proj_angle = str2double(get(handles.projAngle,'String'));
if proj_angle < 0 || proj_angle > 179 || isnan(proj_angle)
    warndlg('The projection angle must range between 0 and 179!','Warning','modal')
    return;
end
detector_index = str2double(get(handles.detectorIndex,'String'));
if detector_index < -4 || detector_index > 3 || isnan(detector_index)
    warndlg('The detector index must range between -4 to 3!','Warning','modal')
    return;
end
drawProjLine(handles.projAxes, proj_angle, detector_index);
system_matrix =  intersection(proj_angle, detector_index);
set(handles.lengthDataTable,'Data',system_matrix);
drawScaledColorImage(handles.imagescAxes, system_matrix);
%============================================================%
% length data table
function lengthDataTable_CreateFcn(hObject, ~, ~)
hObject.ColumnName = {'intersection|X','intersection|Y','intersection|length','grid|number'};
hObject.BackgroundColor = [.4 .4 .4; .4 .4 .8];
hObject.ForegroundColor = [1 1 1];

% imagesc axes
function imagescAxes_CreateFcn(hObject, ~, ~)
imagescAxesInitialize(hObject);
%============================================================%
function projAxesInitialize(hObject)
hObject.XAxisLocation = 'origin';
hObject.YAxisLocation = 'origin';
hObject.XLim = [-7 7];
hObject.YLim = [-7 7];
hObject.XGrid = 'on';
hObject.YGrid = 'on';
hObject.TickLength = [0 0];
hObject.XTick = -8:8;
hObject.YTick = -8:8;
hObject.FontSize = 7;
hObject.Box = 'on';
drawPixelGrid(hObject);
function imagescAxesInitialize(hObject)
hObject.XLim = [0.5 8.5];
hObject.YLim = [0.5 8.5];
hObject.TickLength = [0 0];
hObject.XTick = 1:8;
hObject.YTick = 1:8;
hObject.Box = 'on';

%============================================================%
function projAxesPanel_CreateFcn(hObject, ~, ~)
hObject.Title = '8X8 Grid Simulation';
hObject.TitlePosition = 'centertop';
hObject.FontSize = 10;
hObject.FontWeight = 'bold';
function imagescAxesPanel_CreateFcn(hObject, ~, ~)
hObject.Title = 'Scaled Color Image';
hObject.TitlePosition = 'centertop';
hObject.FontSize = 10;
hObject.FontWeight = 'bold';
function lengthDataTablePanel_CreateFcn(hObject, ~, ~)
hObject.Title = 'Intersection Data';
hObject.TitlePosition = 'centertop';
hObject.FontSize = 10;
hObject.FontWeight = 'bold';
function traversalBtnPanel_CreateFcn(hObject, ~, ~)
hObject.Title = 'Traversal All Angle';
hObject.TitlePosition = 'centertop';
hObject.FontSize = 8;
function traversalSpeedPanel_CreateFcn(hObject, ~, ~)
hObject.Title = 'Traversal Speed';
hObject.FontSize = 7;
function projParaPanel_CreateFcn(hObject, ~, ~)
hObject.Title = 'Set Projection Parameter';
hObject.TitlePosition = 'centertop';
hObject.FontSize = 8;
function traversalSpeedSlider_CreateFcn(hObject, ~, ~)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject, 'min',0.1, 'max',2, 'Value',0.5, 'sliderstep',[0.2 0.2]);
%============================================================%
function traversalBeginButton_Callback(~, ~, handles)
handles.drawProjLineButton.Enable = 'off';
handles.cleanButton.Enable = 'off';
for proj_angle = 0:179
    for detector_index = -4:3
        %axes(handles.projAxes) ;
        cla reset;
        projAxesInitialize(handles.projAxes);
        set(handles.projAngle,'String',proj_angle);
        set(handles.detectorIndex,'String',detector_index);
        drawProjLine(handles.projAxes, proj_angle, detector_index);
        system_matrix = intersection(proj_angle, detector_index);
        set(handles.lengthDataTable,'Data',system_matrix);
        drawScaledColorImage(handles.imagescAxes, system_matrix);
        pause(get(handles.traversalSpeedSlider,'value'));
    end
end


%============================================================%
function traversalPauseButton_Callback(hObject, ~, handles)
hObject.Visible = 'off';
handles.traversalGoButton.Visible = 'on';
handles.drawProjLineButton.Enable = 'on';
handles.cleanButton.Enable = 'on';
uiwait();
function traversalPauseButton_CreateFcn(~, ~, ~)

%============================================================%
function traversalGoButton_Callback(hObject, ~, handles)
hObject.Visible = 'off';
handles.traversalPauseButton.Visible = 'on';
handles.drawProjLineButton.Enable = 'off';
handles.cleanButton.Enable = 'off';
uiresume();
function traversalGoButton_CreateFcn(hObject, ~, ~)
hObject.Visible = 'off';

%============================================================%
function traversalSpeedText_Callback(~, ~, ~)
function traversalSpeedText_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',0.5);

%============================================================%
function traversalSpeedSlider_Callback(hObject, ~, handles)
set(handles.traversalSpeedText,'string',num2str(get(hObject,'value')));

%============================================================%
function drawProjLineButton_KeyPressFcn(~, ~, ~)
function cleanButton_Callback(~, ~, handles)
axes(handles.projAxes) ;
cla reset;
projAxesInitialize(handles.projAxes);
axes(handles.imagescAxes) ;
cla reset;
imagescAxesInitialize(handles.imagescAxes);
set(handles.lengthDataTable,'data','');
