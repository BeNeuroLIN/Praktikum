%% 1. Experiment parameters.

clear b theshold NumFish FrameRate Interval expName

% in expNmame write the group name
expName = '1min tapping';



b = 1; % binlength (in minutes) to convert pixel data to seconds-with-motion (see below)
threshold = 2; % threshold how many pixels represents a real movement, rather than noise in the data?
NumFish = 24 % the number of fish in the box
%FrameRate = 30; % NEW NOTE: Now derive this from actual timestamp data below
Interval = 60; % the number of seconds over which we sum the bouts

%% 2. Load motion file (DELTA PIXELS)
%get filename and path, go to folder, open file
tic
[filename_motion, PathName, FilterIndex]=uigetfile('*');
cd(PathName);
fopen(filename_motion);             
clear data96
data96 = fread(fopen(filename_motion), inf, 'uint16=>uint16', 'b'); % returns one column with fish1 t1, fish2 t1, ...., fish96, fish1 t2, fish2 t2...
data96 = reshape(data96, 24, []);  %96 % number of rows m NumFish x number of columns n [] of data
data96 = rot90(data96, 3); % rotate matrix counterclockw by k*90 degree
data96 = fliplr(data96); % flip matrix left-right (vertical axis)
d96 = double(data96);
toc

%% 3. Load timestamp file
%get filename and path, go to folder, open file
tic
[filename_time, PathName, FilterIndex]=uigetfile('*');
cd(PathName);
fopen(filename_time);
clear timeArray           
timeArrayCell = importdata(filename_time); % import timestamp txt file to matlab
startTime = timeArrayCell(1,:);
endTime = timeArrayCell(end,:);
% determine length of time vector
[time_m, time_n] = size(timeArrayCell); 
toc

%% 4. Automatically find frame # for day/night transitions

% MANUALLY INPUT dates first according to timestamp file:
day0 = '4/1/2026'; % start date, no "0" in date!
day1 = '4/2/2026'; % Lights on at 9am (for ctrl); Run ends 11pm this day

% output frame numbers for desired transitions 
% Below, specified a few phases based on your test file, but can be
% changed/renamed as desired. 

% begiining of the experiment
frame_day0 = strfind(timeArrayCell, (strcat(day0,'5:00:00 PM'))); % change time to experiment begin time
frame_day0 = find(not(cellfun('isempty', frame_day0)));
size_frame_day0 = size(frame_day0,1);
frame_day0 = frame_day0(1,1);

% beginning of first night 
frame_night1 = strfind(timeArrayCell, (strcat(day0,'11:00:00 PM'))); % night starts at 11PM
frame_night1 = find(not(cellfun('isempty', frame_night1)));
size_frame_night1 = size(frame_night1,1);
frame_night1 = frame_night1(1,1);

% beginning of light phase the next morning
frame_day1 = strfind(timeArrayCell, (strcat(day1,'9:00:00 AM'))); % lights are switched on at 9AM on the next day
frame_day1 = find(not(cellfun('isempty', frame_day1)));
size_frame_day1 = size(frame_day1,1);
frame_day1 = frame_day1(1,1);

% beginning of lights off rebound test phase 
frame_testphase = strfind(timeArrayCell, (strcat(day1,'12:00:00 PM')));
frame_testphase = find(not(cellfun('isempty', frame_testphase)));
size_frame_testphase = size(frame_testphase,1);
frame_testphase = frame_testphase(1,1);


% Time near the end of the experiment: for now use night 2
frame_night2 = strfind(timeArrayCell, (strcat(day1,'3:00:00 PM')));
frame_night2 = find(not(cellfun('isempty', frame_night2)));
size_frame_night2 = size(frame_night2,1);
frame_night2 = frame_night2(1,1);


% Mean framerate calculated based on desired time interval
% 210820 test dataset: looks like framerate is closer to 13-15??
frame_mean = (frame_night2-frame_day0)/(24*60*60); %seconds in a day
% Set "official"  to nearest 0.5
framerate = round(frame_mean);
csvwrite('framerate.csv', framerate); %print this in case you need it later


%% 5. Clip data for consistent plotting using timestamp/frame:

% Using time interval from above: beginning of night until end of experiment
%d96_clip = d96(frame_night1:frestrame_night2,:); % last one originally ":"
d96_clip = d96(frame_day0:frame_night2,:);
%% 6. Bin activity/
% According to Prober 2006 and Rihel 2010.
% Activity = seconds with motion, 
% Convert pixel data to seconds-with-motion data
% and bin into 1 minute intervals (because 'rest bout' as defined in these
% papers is a 1-minute period of continuous rest). Will process individual
% movement data in later section
clear b t a 
b = 1; % binlength in minutes to convert pixel data to seconds with motion
t = 2; % threshold how many pixels represent a real movement, rather than noise

a_clip = fct_BinActivity(d96_clip,b,threshold,framerate);
% activity is active seconds per minute
% For a standard 3day run, expect ~3480 bins.

%% 7. ENTER GENOTYPE INFORMATION
%!!!!!!!!!!!!!!!NOTE ORIENTATION OF NUMBER SYSTEM!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% Numbering here runs by column

% SD experiments: Since you want to analyze only 1 group per plate, can
% use the 'ctrl' variable below as stand-in

ctrl = [1:24]; % put in the number of animals from your experiment
allWells = [1:24]

% Save the fish #s in case you want to reanalyze later
fish_ids = fopen('fish_ids_group_1.txt','w');
fprintf(fish_ids,'%.0f,', ctrl);
fclose(fish_ids);

%% 8. OVERVIEW STATISTICS
clear subplot

geno = {'ctrl'; ctrl};

%Overall entire run info:
fct_crNormalDistr(a_clip, expName, geno, allWells, ctrl) %change to a for whole recording time


%% 9. ACTIVITY/REST PLOTS
% this calculates:
% waking activity (seconds of motion per 'waking minute')
%   where a 'waking minute' is a 
% minute with any activity
% rest (number of resting minutes in each 10 minute interval)
% activity (number of active seconds per 10 minute interval)

geno = {'ctrl'; ctrl};

%To plot the designated timeframe based on d96_clip:
% Save as svg for best results in Illustrator, etc
% MANUALLY SAVE from window to preserve display dimensions
a = a_clip
f = fct_crSleepPlots(a,geno,expName);
%files and plots

% Export structure f by genotype in case you want to replot outside Matlab
T_f = struct2table(f, 'AsArray', 1);
csvwrite('output_binned_rest_ctrl.csv', T_f.rest{1}); % ctrl
csvwrite('output_binned_wakeAct_ctrl.csv', T_f.wakeAct{1}); % ctrl
csvwrite('output_binned_act_ctrl.csv', T_f.activity{1}); % ctrl
