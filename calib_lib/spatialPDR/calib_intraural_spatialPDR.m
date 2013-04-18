function calib_intraural_spatialPDR()
% lds calib intraural (Knowles in Owl Ears)
global PDR H TDT KNOWLES HRTF

% SCREEN DIMENSIONS IN PIXELS
screen = get(0,'ScreenSize'); % screen = [left bottom width height]
left = screen(1); 
bottom = screen(2);
width = screen(3)-screen(1);
height = screen(4)-screen(2);

% CREATE NEW FIGURE
fig_left = left + .4*width; % left edge shifted 55% across screen
fig_bottom = bottom + .05*height; % bottom edge shifted 5% up screen
fig_width = .5*width; % fig width = 40% of screen width
fig_height = .8*height; % fig height = 80% of screen height

H.fig = figure('Units','pixels',...
    'Position',[fig_left fig_bottom fig_width fig_height],...
    'Name','Interaural Calibrations (Spatial PDR)',...
    'NumberTitle','off',...
    'Toolbar','none');
set(gcf,'Menubar','none')

% buttons
H.opt = uicontrol('Parent',H.fig,...
    'Style','text',...
    'Units','normalized',...
    'Position',[.05 .9 .3 .1],...
    'ForegroundColor','Black',...
    'BackgroundColor',[.7 .7 1],...
    'String','Options');

% calib knowles button
H.calib_knowles_btn = uicontrol('Parent',H.fig,...
    'Style','pushbutton',...
    'Units','normalized',...
    'Position',[.05 .80 .3 .1],...
    'BackgroundColor','white',...
    'ForegroundColor','blue',...
    'String','Calib Knowles',...
    'Enable','on',...
    'Callback',@run_knowles_calibration);

% load a knowles file
H.load_knowles_data_btn = uicontrol('Parent',H.fig,...
    'Style','pushbutton',...
    'Units','normalized',...
    'Position',[.05 .70 .3 .1],...
    'BackgroundColor','white',...
    'ForegroundColor','blue',...
    'String','Load Knowles Data',...
    'Enable','off',...
    'Callback',@load_knowles);

% init setup button
H.init_btn = uicontrol('Parent',H.fig,...
    'Style','pushbutton',...
    'Units','normalized',...
    'Position',[.05 .60 .3 .1],...
    'BackgroundColor','white',...
    'ForegroundColor','blue',...
    'String','Init Setup',...
    'Callback','init_calib_setup_spatialPDR');

% calibrate all sound tokens
H.calib_snd_btn = uicontrol('Parent',H.fig,...
    'Style','pushbutton',...
    'Units','normalized',...
    'Position',[.05 .50 .3 .1],...
    'BackgroundColor','white',...
    'ForegroundColor','blue',...
    'Enable','off',...
    'String','Engage Tokens Calib',...
    'Callback','engage_tokens_calib');

% quit button
H.quit = uicontrol('Parent',H.fig,...
    'Style','pushbutton',...
    'Units','normalized',...
    'Position',[.05 .30 .3 .1],...
    'BackgroundColor','red',...
    'ForegroundColor','yellow',...
    'String','QUIT',...
    'Callback','close(gcf)');

% owl ID entry
H.owl_id1 = uicontrol('Parent',H.fig,...
    'Style','text',...
    'Units','normalized',...
    'Position',[.05 .2 .15 .05],...
    'BackgroundColor','w',...
    'ForegroundColor','m',...
    'HorizontalAlignment','left',...
    'String','OWL ID#: ');

H.owl_id2 = uicontrol('Parent',H.fig,...
    'Style','text',...
    'Units','normalized',...
    'Position',[.2 .2 .1 .05],...
    'BackgroundColor','k',...
    'ForegroundColor','k',...
    'String','',...
    'HorizontalAlignment','left');

% display calib files
H.knowles1 = uicontrol('Parent',H.fig,...
    'Style','text',...
    'Units','normalized',...
    'Position',[.05 .15 .15 .05],...
    'BackgroundColor',[.9 .9 .9],...
    'ForegroundColor','k',...
    'HorizontalAlignment','left',...
    'String','Knowles Calib FN: ');

H.knowles2 = uicontrol('Parent',H.fig,...
    'Style','text',...
    'Units','normalized',...
    'Position',[.2 .15 .4 .05],...
    'BackgroundColor',[.9 .9 .9],...
    'ForegroundColor','k',...
    'HorizontalAlignment','left',...
    'String','...');

H.intraural1 = uicontrol('Parent',H.fig,...
    'Style','text',...
    'Units','normalized',...
    'Position',[.05 .1 .15 .05],...
    'BackgroundColor',[.9 .9 .9],...
    'ForegroundColor','k',...
    'HorizontalAlignment','left',...
    'String','Intraural Calib FN: ');

H.intraural2 = uicontrol('Parent',H.fig,...
    'Style','text',...
    'Units','normalized',...
    'Position',[.2 .1 .4 .05],...
    'BackgroundColor',[.9 .9 .9],...
    'ForegroundColor','k',...
    'HorizontalAlignment','left',...
    'String','...');

function set_owl_id(hObject,eventdata)
global PDR H
PDR.owl_id = str2num(get(H.owl_id2,'String'));

% LOAD PREVIOUSLY GATHERED KNOWLES CALIBRATION DATA
function load_knowles(hObject,eventdata)
global KNOWLES PDR H
cd(PDR.data_path);
uiopen('knowles*.mat');
PDR.knowles_file = [KNOWLES.data_path KNOWLES.filename];
set(H.knowles2,'String',[KNOWLES.data_path KNOWLES.filename '.mat']);

function run_knowles_calibration(hObject,eventdata)
% PERFORM CALIBRATION OF KNOWLES MICS
global KNOWLES PDR H
% CHECK IF IT'S OKAY TO CONTINUE
button = questdlg('You need to reset the TDT before continuing. Click OKAY when you''ve done this, or CANCEL otherwise.',...
'Continue Operation','OKAY','CANCEL','OKAY');
if strcmp(button,'OKAY')
elseif strcmp(button,'CANCEL')
   return;
end
KNOWLES=calib_knowles;
PDR.knowles_file = [KNOWLES.data_path KNOWLES.filename];
set(H.knowles2,'String',[KNOWLES.data_path KNOWLES.filename '.mat']);