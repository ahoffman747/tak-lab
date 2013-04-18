function init_calib_setup_spatialPDR
% initialize TDT and set up for calibrations
global PDR H TDT HRTF

% CHECK IF IT'S OKAY TO CONTINUE
button = questdlg('You need to reset the TDT before continuing. Click OKAY when you''ve done this, or CANCEL otherwise.',...
'Continue Operation','OKAY','CANCEL','OKAY');
if strcmp(button,'OKAY')
elseif strcmp(button,'CANCEL')
   return;
end

% SETUP PARAMETERS
% NOTE: This structure should be saved as CALIB_PDR to avoid confusion
% but for all the scripts to work it needs to be called PDR for now!

PDR = struct(...                        % MAIN PARAMETERS:
    'calib',1,...                       % flag for calibrations
    'owl_id',0,...                      % for owl ID #
    'virtual',1,...                     % Freefield: virtual = 0, Headphones: virtual = 1
    'record',1,...                      % flag for recording CALIB_PDR trace
    'buf_pts',30000,...              
    'stim_Fs',30000,...                 % sampling rate for sound production (1 second calibration sounds)
    'npts_totalplay',[],...             % total no. pts in the session
    'len_session',[], ...               % length of session (in minutes)
    'starttime',[], ...                 % session start time
    'stoptime', [], ...                 % session stop time
    'code_path', 'c:\andrew\code\',...    % path to code
    'data_path', 'c:\andrew\calib_data\',...     % flag indicates that AD recording (pupillometer) will be needed
    'base_atten',0,...                  % attenuation value to send to TDT (combining scale_val and atten gives a certain SPL in dB -- This needs to be calibrated!!!)
    'filename',[],...                   % file name for storing session data
    ...
    ...                                 % CALIBRATION PARAMETERS:
    'TEST_ramp',5,...
    'TEST_seed',47,...
    'TEST_base_rms',0.0350,...
    'calibtype',[],...                  % What are we calibrating? (Knowles alone, Knowles in owl's ears)
    'knowles_file',[],...               % equals 1 if calibrating Knowles voltage output
    'comments','Spatial PDR with Octave Band, BBN and Gammatones (virtual). Intraural Calibrations with Knowles mics.',...             % extra info about sounds
    'nscales',300,...                   % number of scales used for calibrating each sound (5 minutes per sound token)
    'scales_2_try_for_cutoffs',10.^([0:.09:4.5 log10(32760)]),... % these are the scales to try to avoid nonlinearities due to speaker limitations and noise floor, etc.
    ...
    'HRTF_directory','C:\andrew\pdr\HRTF_lib\',...  % directory of HRTF coefficient files
    'HRTF_fname','929AD_ABLequal.eq');

cd(PDR.code_path);
tmp = pwd;
if tmp(end-3:end) == 'code'
    PDR.data_path = [tmp(1:end-4) 'calib_data\'];
else
    error('CALIB:PathSetup','Something could be wrong with the path setup!')
end


cd(PDR.data_path);
Prompt='Enter OWL ID # for this calibration session';
Title='Owl ID';
Answer = inputdlg(Prompt,Title);
PDR.owl_id=str2num(Answer{1});
set(H.owl_id2,'String',Answer{1},'BackgroundColor','w');
PDR.filename = ['intraural_calib_' y m d '_' num2str(PDR.owl_id) 'A'];
count = double('A'+0);
while exist ([PDR.filename '.mat'],'file');
    count = count + 1;
    if count > 90
        disp('There are already several files with similar names!');
        PDR.filename = input('Enter a unique filename for this session: ', 's');
        break;
    else
        PDR.filename(end) = char(count);
    end
end
set(H.intraural2,'String',[PDR.data_path PDR.filename '.mat']);


% INITIALIZE TDT
h=warndlg('CHANNEL 0 = LEFT EAR, CHANNEL 1 = RIGHT EAR ... OKAY???','warning');
uiwait(h);

out=TDT_init;
if(out==-1); return; end;

SRATE =  (1/PDR.stim_Fs)*10^6; % sampling rate for TDT

% INITIATE TDT PARAMETERS HERE
TDT.nPlayChannels=2;
TDT.nBuffers=1;
TDT.bufpts=PDR.buf_pts;
TDT.nRecChannels=1;
TDT.din = 1;
TDT.Fs = PDR.stim_Fs;
TDT.npts_total_play=PDR.buf_pts;
TDT.dec_pts=PDR.buf_pts; % no need to decimate
TDT.srate=1e6 / TDT.Fs;

% PREPARE PD1 FOR CONVERSION:
PD1_init;

% attens (ch1 and ch2)
TDT_attens([PDR.base_atten PDR.base_atten]);

% INITIALIZE BUFFERS
TDT_buffers;

% stimulus buffer ids
TDT.BUF_L1=TDT.stim_buffers(1,1);
TDT.BUF_R1=TDT.stim_buffers(1,2);
TDT.REC_L1=TDT.rec_buffers(1,1);
TDT.REC_R1=TDT.rec_buffers(1,2);

% MAKE CALIB SOUNDS
HRTF = make_calib_sounds;

%write header information to file... saving global variables
set(H.calib_snd_btn,'Enable','on');
set(H.owl_id2,'Enable','on','BackgroundColor','w','String',num2str(PDR.owl_id));
set(H.load_knowles_data_btn,'Enable','on');
CALIB_PDR=PDR:
save ([CALIB_PDR.data_path CALIB_PDR.filename '.mat'],'CALIB_PDR');
str{1} = 'Variables saved in: ';
str{2} = [CALIB_PDR.data_path CALIB_PDR.filename '.mat'];
clear CALIB_PDR
hMsg=msgbox(str); uiwait(hMsg);
