%ITD_decorr: the GUI for ITD_decorr tests

%*******************************************************************************
%	The Graphical User Interface
% this version allows differing filenames for each ear
%*******************************************************************************

XStimParams.reset_flag = 0;

F.inc = 20;
%Figure window
if(~exist1('H.searchfig') &...
      ~exist1('H.ablfig') &...
      ~exist1('H.itdfig') &...
      ~exist1('H.itd_decorrfig') &...
      ~exist1('H.ildfig') &...
      ~exist1('H.ildfreqfig') &...
      ~exist1('H.spacefig') &...
      ~exist1('H.ildalonefig'))
   Xstim_control_pos = get(H.fig,'Position');
   F.x0 = Xstim_control_pos(3) - 300; F.width = 350; F.height = 800;
   H.itd_decorrfig = figure('Units','pixels',...
      'Position',[F.x0 50 F.width F.height],...
      'Name','ITD_decorr Test',...
      'NumberTitle','off');
F.current_height = 0;
F.inc_height = 20; F.current_height = F.current_height + F.inc_height;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height F.width F.inc_height],...
   'ForegroundColor','blue',...
   'FontWeight','bold',...
   'String', 'ITD_decorr Measurement');

%ITD Information
F.current_height = F.current_height + F.inc_height + F.inc;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height F.width F.inc_height],...
   'BackgroundColor','blue',...
   'ForegroundColor','white',...
   'FontWeight','bold',...
   'String', 'Specify ITD_decorr Parameters');
F.current_height = F.current_height + F.inc_height;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height 80 F.inc_height],...
   'String', 'Low ITD:');
H.lowitd = uicontrol('Style','edit',...
   'Units','pixels',...
   'Position',[82 F.height-F.current_height 60 F.inc_height],...
   'String', num2str(XStimParams.loitd),...
   'Callback','setinfo_itd_decorr');
F.current_height = F.current_height + F.inc_height;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height 80 F.inc_height],...
   'String', 'High ITD:');
H.highitd = uicontrol('Style','edit',...
   'Units','pixels',...
   'Position',[82 F.height-F.current_height 60 F.inc_height],...
   'String', num2str(XStimParams.hiitd),...
   'Callback','setinfo_itd_decorr');
F.current_height = F.current_height + F.inc_height;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height 80 F.inc_height],...
   'String', 'Num ITDs:');
H.numitds = uicontrol('Style','edit',...
   'Units','pixels',...
   'Position',[82 F.height-F.current_height 60 F.inc_height],...
   'String', num2str(XStimParams.numitds),...
   'Callback','setinfo_itd_decorr');
F.current_height = F.current_height + F.inc_height;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height 80 F.inc_height],...
   'String', 'ITD Step:');

H.stepitd = uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[82 F.height-F.current_height 60 F.inc_height]);

%Other Stimulus Parameters
F.current_height = F.current_height + F.inc_height + F.inc;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height F.width F.inc_height],...
   'BackgroundColor','blue',...
   'ForegroundColor','white',...
   'FontWeight','bold',...
   'String', 'Set Remaining Parameters');

%ILD
F.current_height = F.current_height + F.inc_height;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height 110 F.inc_height],...
   'String', 'ILD (dB):');
H.ILD = uicontrol('Style','edit',...
   'Units','pixels',...
   'Position',[112 F.height-F.current_height 60 F.inc_height],...
   'String', num2str(XStimParams.curr_ILD),...
   'Callback','setinfo_itd_decorr');
%ABL
F.current_height = F.current_height + F.inc_height;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height 110 F.inc_height],...
   'String', 'ABL (dB):');

H.ABL = uicontrol('Style','edit',...
   'Units','pixels',...
   'Position',[112 F.height-F.current_height 60 F.inc_height],...
   'String', num2str(XStimParams.curr_ABL),...
   'Callback','setinfo_itd_decorr');
%DUR
F.current_height = F.current_height + F.inc_height;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height 110 F.inc_height],...
   'String', 'Stim Dur (ms):');
H.DUR = uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[112 F.height-F.current_height 60 F.inc_height],...
   'String', num2str(XStimParams.curr_stimdur));

%ISI
F.current_height = F.current_height + F.inc_height;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height 110 F.inc_height],...
   'String', 'ISI (ms):');
H.ISI = uicontrol('Style','edit',...
   'Units','pixels',...
   'Position',[112 F.height-F.current_height 60 F.inc_height],...
   'String', num2str(XStimParams.test_ISI),...
   'Callback','setinfo_itd_decorr');

%NumReps
F.current_height = F.current_height + F.inc_height;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height 110 F.inc_height],...
   'String', '# Reps:');
H.numreps = uicontrol('Style','edit',...
   'Units','pixels',...
   'Position',[112 F.height-F.current_height 60 F.inc_height],...
   'String', num2str(XStimParams.numreps),...
   'Callback','setinfo_itd_decorr');

% increment test number
H.inc_testnum = uicontrol('Style','pushbutton',...
   'Units','pixels',...
   'Position',[200 F.height-F.current_height 140 F.inc_height],...
   'BackgroundColor','yellow',...
   'ForegroundColor','blue',...
   'FontWeight','bold',...
   'String', 'INCREMENT testnum',...
   'Callback','setinfo_itd_decorr');

%%%%%%% matrix of stimuli
F.current_height = F.current_height + F.inc_height + F.inc;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height F.width F.inc_height],...
   'BackgroundColor','blue',...
   'ForegroundColor','white',...
   'FontWeight','bold',...
   'String', 'Stimulus Matrix');
% stimuli for higher freq
F.current_height = F.current_height + F.inc_height;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[2 F.height-F.current_height 70 F.inc_height],...
   'String', 'hi freq FN->');

uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[80 F.height-F.current_height 60 F.inc_height],...
   'String', 'none');

uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[150 F.height-F.current_height 60 F.inc_height],...
   'String', 'coherent');
H.stim_FN4pb = uicontrol('Style','pushbutton',...
   'Units','pixels',...
   'Position',[145 F.height-F.current_height-F.inc_height 10 F.inc_height],...
   'BackgroundColor','red',...
   'Callback','setinfo_itd_decorr');
H.stim_FN4 = uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[150 F.height-F.current_height-F.inc_height 60 F.inc_height],...
   'ForegroundColor','black',...
   'String', FN.stim4L(1:end-5));

uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[220 F.height-F.current_height 60 F.inc_height],...
   'String', 'level1');
H.stim_FN5pb = uicontrol('Style','pushbutton',...
   'Units','pixels',...
   'Position',[215 F.height-F.current_height-F.inc_height 10 F.inc_height],...
   'BackgroundColor','red',...
   'Callback','setinfo_itd_decorr');
H.stim_FN5 = uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[220 F.height-F.current_height-F.inc_height 60 F.inc_height],...
   'ForegroundColor','black',...
   'String', FN.stim5L(1:end-5));

uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[290 F.height-F.current_height 60 F.inc_height],...
   'String', 'level2');
H.stim_FN6pb = uicontrol('Style','pushbutton',...
   'Units','pixels',...
   'Position',[285 F.height-F.current_height-F.inc_height 10 F.inc_height],...
   'BackgroundColor','red',...
   'Callback','setinfo_itd_decorr');
H.stim_FN6 = uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[290 F.height-F.current_height-F.inc_height 60 F.inc_height],...
   'ForegroundColor','black',...
   'String', FN.stim6L(1:end-5));

% stimuli for lower freq
F.current_height = F.current_height + F.inc_height*2;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[15 F.height-F.current_height 70 F.inc_height],...
   'String', 'lo freq FN v');

F.current_height = F.current_height + F.inc_height;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[32 F.height-F.current_height 40 F.inc_height],...
   'String', 'none');
% check boxes
H.stims_to_play(1,1) = uicontrol('Style','togglebutton',...
   'visible','off',...
   'Units','pixels',...
   'Position',[110 F.height-F.current_height 20 F.inc_height],...
   'Callback','setinfo_itd_decorr');
H.stims_to_play(1,2) = uicontrol('Style','togglebutton',...
   'Units','pixels',...
    'backgroundcolor',[.9 .9 .9],...
    'Position',[170 F.height-F.current_height 20 F.inc_height],...
   'Callback','setinfo_itd_decorr');
H.stims_to_play(1,3) = uicontrol('Style','togglebutton',...
   'Units','pixels',...
    'backgroundcolor',[.6 .6 .6],...
   'Position',[240 F.height-F.current_height 20 F.inc_height],...
   'Callback','setinfo_itd_decorr');
H.stims_to_play(1,4) = uicontrol('Style','togglebutton',...
   'Units','pixels',...
    'backgroundcolor',[.6 .6 .6],...
   'Position',[310 F.height-F.current_height 20 F.inc_height],...
   'Callback','setinfo_itd_decorr');

F.current_height = F.current_height + F.inc_height;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[2 F.height-F.current_height 40 F.inc_height],...
   'String', 'coherent');
H.stim_FN7pb = uicontrol('Style','pushbutton',...
   'Units','pixels',...
   'Position',[95 F.height-F.current_height 10 F.inc_height],...
   'BackgroundColor','red',...
   'Callback','setinfo_itd_decorr');
H.stim_FN7 = uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[44 F.height-F.current_height 50 F.inc_height],...
   'ForegroundColor','black',...
   'String', FN.stim7L(1:end-5));
% check boxes
H.stims_to_play(2,1) = uicontrol('Style','togglebutton',...
   'Units','pixels',...
    'backgroundcolor',[.9 .9 .9],...
   'Position',[110 F.height-F.current_height 20 F.inc_height],...
   'Callback','setinfo_itd_decorr');
H.stims_to_play(2,2) = uicontrol('Style','togglebutton',...
   'Units','pixels',...
    'backgroundcolor',[.9 .9 .9],...
   'Position',[170 F.height-F.current_height 20 F.inc_height],...
   'Callback','setinfo_itd_decorr');
H.stims_to_play(2,3) = uicontrol('Style','togglebutton',...
   'Units','pixels',...
    'backgroundcolor',[.6 .6 .6],...
   'Position',[240 F.height-F.current_height 20 F.inc_height],...
   'Callback','setinfo_itd_decorr');
H.stims_to_play(2,4) = uicontrol('Style','togglebutton',...
   'Units','pixels',...
    'backgroundcolor',[.6 .6 .6],...
   'Position',[310 F.height-F.current_height 20 F.inc_height],...
   'Callback','setinfo_itd_decorr');

F.current_height = F.current_height + F.inc_height;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[2 F.height-F.current_height 40 F.inc_height],...
   'String', 'level1');
H.stim_FN8pb = uicontrol('Style','pushbutton',...
   'Units','pixels',...
   'Position',[95 F.height-F.current_height 10 F.inc_height],...
   'BackgroundColor','red',...
   'Callback','setinfo_itd_decorr');
H.stim_FN8 = uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[44 F.height-F.current_height 50 F.inc_height],...
   'ForegroundColor','black',...
   'String', FN.stim8L(1:end-5));
% check boxes
H.stims_to_play(3,1) = uicontrol('Style','togglebutton',...
   'Units','pixels',...
    'backgroundcolor',[.8 .8 .8],...
   'Position',[110 F.height-F.current_height 20 F.inc_height],...
   'Callback','setinfo_itd_decorr');
H.stims_to_play(3,2) = uicontrol('Style','togglebutton',...
   'Units','pixels',...
    'backgroundcolor',[.8 .8 .8],...
   'Position',[170 F.height-F.current_height 20 F.inc_height],...
   'Callback','setinfo_itd_decorr');
H.stims_to_play(3,3) = uicontrol('Style','togglebutton',...
   'Units','pixels',...
    'backgroundcolor',[.3 .3 .3],...
   'Position',[240 F.height-F.current_height 20 F.inc_height],...
   'Callback','setinfo_itd_decorr');
H.stims_to_play(3,4) = uicontrol('Style','togglebutton',...
   'Units','pixels',...
    'backgroundcolor',[.3 .3 .3],...
   'Position',[310 F.height-F.current_height 20 F.inc_height],...
   'Callback','setinfo_itd_decorr');

F.current_height = F.current_height + F.inc_height;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[2 F.height-F.current_height 40 F.inc_height],...
   'String', 'level2');
H.stim_FN9pb = uicontrol('Style','pushbutton',...
   'Units','pixels',...
   'Position',[95 F.height-F.current_height 10 F.inc_height],...
   'BackgroundColor','red',...
   'Callback','setinfo_itd_decorr');
H.stim_FN9 = uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[44 F.height-F.current_height 50 F.inc_height],...
   'ForegroundColor','black',...
   'String', FN.stim9L(1:end-5));
% check boxes
H.stims_to_play(4,1) = uicontrol('Style','togglebutton',...
   'Units','pixels',...
    'backgroundcolor',[.8 .8 .8],...
   'Position',[110 F.height-F.current_height 20 F.inc_height],...
   'Callback','setinfo_itd_decorr');
H.stims_to_play(4,2) = uicontrol('Style','togglebutton',...
   'Units','pixels',...
    'backgroundcolor',[.8 .8 .8],...
   'Position',[170 F.height-F.current_height 20 F.inc_height],...
   'Callback','setinfo_itd_decorr');
H.stims_to_play(4,3) = uicontrol('Style','togglebutton',...
   'Units','pixels',...
    'backgroundcolor',[.3 .3 .3],...
   'Position',[240 F.height-F.current_height 20 F.inc_height],...
   'Callback','setinfo_itd_decorr');
H.stims_to_play(4,4) = uicontrol('Style','togglebutton',...
   'Units','pixels',...
    'backgroundcolor',[.4 .4 .4],...
   'Position',[310 F.height-F.current_height 20 F.inc_height],...
   'Callback','setinfo_itd_decorr');

%
F.current_height = F.current_height + F.inc_height*3;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height F.width F.inc_height],...
   'BackgroundColor','blue',...
   'ForegroundColor','white',...
   'FontWeight','bold',...
   'String', 'Run Test');

%Engage TEST
F.current_height = F.current_height + F.inc_height;
H.engageitd_decorr = uicontrol('Style','pushbutton',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height 80 F.inc_height],...
   'BackgroundColor','green',...
   'ForegroundColor','white',...
   'FontWeight','bold',...
   'String', 'ENGAGE',...
   'Callback','Engage_itd_decorr');

%Record Data?
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[85 F.height-F.current_height 100 F.inc_height],...
   'String', 'Record Data?');
H.recorddata = uicontrol('Style','checkbox',...
   'Units','pixels',...
   'Position',[190 F.height-F.current_height 30 F.inc_height]);
H.recorddata_FN = uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[85 F.height-(F.current_height+F.inc_height) 100 F.inc_height],...
   'String', FN.data);

%Reset
H.resetitd_decorr = uicontrol('Style','togglebutton',...
   'Units','pixels',...
   'Position',[F.width-100 F.height-F.current_height 80 F.inc_height],...
   'BackgroundColor','cyan',...
   'ForegroundColor','black',...
   'FontWeight','bold',...
   'String', 'Reset',...
   'Callback', 'reset_itd_decorr');

%Pause TEST
F.current_height = F.current_height + F.inc_height*2;
H.pauseitd_decorr = uicontrol('Style','togglebutton',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height 80 F.inc_height],...
   'BackgroundColor','blue',...
   'ForegroundColor','white',...
   'FontWeight','bold',...
   'String', 'Pause');

%Exit
H.exititd_decorr = uicontrol('Style','togglebutton',...
   'Units','pixels',...
   'Position',[F.width-100 F.height-F.current_height 80 F.inc_height],...
   'BackgroundColor','red',...
   'ForegroundColor','yellow',...
   'FontWeight','bold',...
   'String', 'EXIT',...
   'Callback','Exit_itd_decorr');

%Build/Play Trials
F.current_height = F.current_height + F.inc_height + F.inc;
H.buildplay = uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height 175 F.inc_height],...
   'BackgroundColor','yellow',...
   'ForegroundColor','blue',...
   'String', 'Build/Play Status');

%Remaining Reps and Trials
F.current_height = F.current_height + F.inc_height;
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[0 F.height-F.current_height 100 F.inc_height],...
   'String', 'Remaining reps:');
H.remreps = uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[102 F.height-F.current_height 40 F.inc_height],...
   'String', get(H.numreps,'String'));
uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[144 F.height-F.current_height 80 F.inc_height],...
   'String', 'Trials:');
H.remtrials = uicontrol('Style','text',...
   'Units','pixels',...
   'Position',[226 F.height-F.current_height 40 F.inc_height],...
   'String', '');

end %end GUI specification

stimuli_dir = FN.temp_stim_path;
setinfo_itd_decorr;

% Initialize Application and get AP2 and XBUS locks
if(S232('S2init', 0, 'INIT_PRIMARY', 10000) == 0)
   disp('Cannot initialize a secondary process')
   return;
end

if(S232('APlock', 100, 0) == 0)
  disp('Cannot acquire lock on AP2 Card')
  s232('S2close');
  return;
end

if(S232('XBlock', 100, 0) == 0)
  disp('Cannot acquire lock on X Bus')
  s232('APunlock', 0);
  s232('S2close');
  return;
end