% Section 1
% Open the COVID-19 Wearables folder to run the code
%% NOTE: 
% Heartrate data is averaged throughout the patients'observed period rather
% than a daily basis. An example of daily mean heartrate is shown at the
% bottom of the script for patient 2. This was done to compare it with
% daily steps data. Overall little meaningful information was lost by
% expanding the window of observed mean heartrate.

%% Patient: A0NVTRV
% Finding Measures of Central Tendency and Dispersion
% For heart-rate, steps, and sleep, relevant central tendency data is the mean and median
% For heart-rate, steps, and sleep, relevant dispersion data is the range and standard deviation

%% HEARTRATE

Pat1hr = readtable('A0NVTRV_hr.csv');
hr = Pat1hr.heartrate;
locate = [mean(hr) median(hr)];
stats = [range(hr) std(hr)];

sprintf('The mean of heart rate for Patient A0NVTRV = %2.2f bpm.', locate(1))
sprintf('The median of heart rate for Patient A0NVTRV = %2.2f bpm.', locate(2))

sprintf('The range of heart rate data for Patient A0NVTRV = %2.2f bpm.', stats(1))
sprintf('The standard deviation of heart rate data for Patient A0NVTRV = %2.2f bpm.', stats(2))


%% SLEEP

%Following Paul's Piazza post. Will combine all non "wake" stages into one
% "sleep" category. Will add up all sleep categories, then perform central 
% tendency and dispersion calculations on that sleep data

Pat1sleep = readtable('A0NVTRV_sleep.csv');

Pat1sleep.stage(strcmp(Pat1sleep.stage,'light')) = {'sleep'};
Pat1sleep.stage(strcmp(Pat1sleep.stage,'deep')) = {'sleep'};
Pat1sleep.stage(strcmp(Pat1sleep.stage,'rem')) = {'sleep'};

%Converting seconds to hours
Pat1sleep.stage_duration = Pat1sleep.stage_duration / 3600; 

%removing all instances of wake and unused variables for retime
Pat1sleep = Pat1sleep(~any(strcmp(Pat1sleep.stage,'wake'),2),:);
Pat1sleep = Pat1sleep(~any(strcmp(Pat1sleep.stage,'awake'),2),:);
Pat1sleep = Pat1sleep(~any(strcmp(Pat1sleep.stage,'restless'),2),:);

Pat1sleep= removevars(Pat1sleep,{'user'});
Pat1sleep= removevars(Pat1sleep,{'stage'});

%summing daily sleep hours 
TT = table2timetable(Pat1sleep);
sumSleep = retime(TT, 'daily', 'sum');

%remove non-data
sumSleep(sumSleep.stage_duration==0,:) = [] ;

sleep = sumSleep.stage_duration;

locate = [mean(sleep) median(sleep)];
stats = [range(sleep) std(sleep)];

sprintf('The mean sleep time for Patient A0NVTRV = %2.2f hours.', locate(1))
sprintf('The median of sleep time for Patient A0NVTRV = %2.2f hours.', locate(2))

sprintf('The range of sleep hours for Patient A0NVTRV = %2.2f hours.', stats(1))
sprintf('The standard deviation of sleep hours for Patient A0NVTRV = %2.2f hours.', stats(2))
%% STEPS

Pat1steps = readtable('A0NVTRV_steps.csv');
Pat1steps= removevars(Pat1steps,{'user'});

%Summing the number of steps taken per day
TT = table2timetable(Pat1steps);
sumSteps = retime(TT, 'daily', 'sum');
steps = sumSteps.steps;

% Finding respective values based on daily results
locate = [mean(steps) median(steps)];
stats = [range(steps) std(steps)];

sprintf('The mean steps for Patient A0NVTRV overall = %2.2f steps.', locate(1))
sprintf('The median of steps for Patient A0NVTRV overall = %2.2f steps.', locate(2))
 
sprintf('The range of steps data for Patient A0NVTRV = %2.2f steps.', stats(1))
sprintf('The standard deviation of steps data for Patient A0NVTRV = %2.2f steps.', stats(2))



%% Patient: A1K5DRI
% Finding Measures of Central Tendency and Dispersion
% For heart-rate, steps, and sleep, relevant central tendency data is the mean and median
% For heart-rate, steps, and sleep, relevant dispersion data is the range and standard deviation,
%% HEARTRATE

Pat2hr = readtable('A1K5DRI_hr.csv');
hr = Pat2hr.heartrate;
locate = [mean(hr) median(hr)];
stats = [range(hr) std(hr)];

sprintf('The mean of heart rate for Patient A1K5DRI = %2.2f bpm.', locate(1))
sprintf('The median of heart rate for Patient A1K5DRI = %2.2f bpm.', locate(2))

sprintf('The range of heart rate data for Patient A1K5DRI = %2.2f bpm.', stats(1))
sprintf('The standard deviation of heart rate data for Patient A1K5DRI = %2.2f bpm.', stats(2))


%% SLEEP

%Following Paul's Piazza post. Will combine all non "wake" stages into one
% "sleep" category. Will add up all sleep categories, then perform central 
% tendency and dispersion calculations on that sleep data

Pat2sleep = readtable('A1K5DRI_sleep.csv');

Pat2sleep.stage(strcmp(Pat2sleep.stage,'light')) = {'sleep'};
Pat2sleep.stage(strcmp(Pat2sleep.stage,'deep')) = {'sleep'};
Pat2sleep.stage(strcmp(Pat2sleep.stage,'rem')) = {'sleep'};

%Converting seconds to hours
Pat2sleep.stage_duration = Pat2sleep.stage_duration / 3600; 

%removing all instances of wake and unused variables for retime
Pat2sleep = Pat2sleep(~any(strcmp(Pat2sleep.stage,'wake'),2),:);
Pat2sleep = Pat2sleep(~any(strcmp(Pat2sleep.stage,'awake'),2),:);
Pat2sleep = Pat2sleep(~any(strcmp(Pat2sleep.stage,'restless'),2),:);

Pat2sleep= removevars(Pat2sleep,{'user'});
Pat2sleep= removevars(Pat2sleep,{'stage'});

%summing daily sleep hours 
TT = table2timetable(Pat2sleep);
sumSleep = retime(TT, 'daily', 'sum');

%remove non-data
sumSleep(sumSleep.stage_duration==0,:) = [] ;

sleep = sumSleep.stage_duration;

locate = [mean(sleep) median(sleep)];
stats = [range(sleep) std(sleep)];

sprintf('The mean sleep time for Patient A1K5DRI = %2.2f hours.', locate(1))
sprintf('The median of sleep time for Patient A1K5DRI = %2.2f hours.', locate(2))

sprintf('The range of sleep hours for Patient A1K5DRI = %2.2f hours.', stats(1))
sprintf('The standard deviation of sleep hours for Patient A1K5DRI = %2.2f hours.', stats(2))
%% STEPS

Pat2steps = readtable('A1K5DRI_steps.csv');
Pat2steps= removevars(Pat2steps,{'user'});

%Summing the number of steps taken per day
TT = table2timetable(Pat2steps);
sumSteps = retime(TT, 'daily', 'sum');
steps = sumSteps.steps;

% Finding respective values based on daily results
locate = [mean(steps) median(steps)];
stats = [range(steps) std(steps)];

sprintf('The mean steps for Patient A1K5DRI overall = %2.2f steps.', locate(1))
sprintf('The median of steps for Patient A1K5DRI overall = %2.2f steps.', locate(2))
 
sprintf('The range of steps data for Patient A1K5DRI = %2.2f steps.', stats(1))
sprintf('The standard deviation of steps data for Patient A1K5DRI = %2.2f steps.', stats(2))



%% Patient: A1ZJ41O
% Finding Measures of Central Tendency and Dispersion
% For heart-rate, steps, and sleep, relevant central tendency data is the mean and median
% For heart-rate, steps, and sleep, relevant dispersion data is the range and standard deviation,
%% HEARTRATE

Pat3hr = readtable('A1ZJ41O_hr.csv');
hr = Pat3hr.heartrate;
locate = [mean(hr) median(hr)];
stats = [range(hr) std(hr)];

sprintf('The mean of heart rate for Patient A1ZJ41O = %2.2f bpm.', locate(1))
sprintf('The median of heart rate for Patient A1ZJ41O = %2.2f bpm.', locate(2))

sprintf('The range of heart rate data for Patient A1ZJ41O = %2.2f bpm.', stats(1))
sprintf('The standard deviation of heart rate data for Patient A1ZJ41O = %2.2f bpm.', stats(2))


%% SLEEP

%Following Paul's Piazza post. Will combine all non "wake" stages into one
% "sleep" category. Will add up all sleep categories, then perform central 
% tendency and dispersion calculations on that sleep data

Pat3sleep = readtable('A1ZJ41O_sleep.csv');

Pat3sleep.stage(strcmp(Pat3sleep.stage,'light')) = {'sleep'};
Pat3sleep.stage(strcmp(Pat3sleep.stage,'deep')) = {'sleep'};
Pat3sleep.stage(strcmp(Pat3sleep.stage,'rem')) = {'sleep'};

%Converting seconds to hours
Pat3sleep.stage_duration = Pat3sleep.stage_duration / 3600; 

%removing all instances of wake and unused variables for retime
Pat3sleep = Pat3sleep(~any(strcmp(Pat3sleep.stage,'wake'),2),:);
Pat3sleep = Pat3sleep(~any(strcmp(Pat3sleep.stage,'awake'),2),:);
Pat3sleep = Pat3sleep(~any(strcmp(Pat3sleep.stage,'restless'),2),:);

Pat3sleep= removevars(Pat3sleep,{'user'});
Pat3sleep= removevars(Pat3sleep,{'stage'});

%summing daily sleep hours 
TT = table2timetable(Pat3sleep);
sumSleep = retime(TT, 'daily', 'sum');

%remove non-data
sumSleep(sumSleep.stage_duration==0,:) = [] ;

sleep = sumSleep.stage_duration;

locate = [mean(sleep) median(sleep)];
stats = [range(sleep) std(sleep)];

sprintf('The mean sleep time for Patient A1ZJ41O = %2.2f hours.', locate(1))
sprintf('The median of sleep time for Patient A1ZJ41O = %2.2f hours.', locate(2))

sprintf('The range of sleep hours for Patient A1ZJ41O = %2.2f hours.', stats(1))
sprintf('The standard deviation of sleep hours for Patient A1ZJ41O = %2.2f hours.', stats(2))
%% STEPS

Pat3steps = readtable('A1ZJ41O_steps.csv');
Pat3steps= removevars(Pat3steps,{'user'});

%Summing the number of steps taken per day
TT = table2timetable(Pat3steps);
sumSteps = retime(TT, 'daily', 'sum');
steps = sumSteps.steps;

% Finding respective values based on daily results
locate = [mean(steps) median(steps)];
stats = [range(steps) std(steps)];

sprintf('The mean steps for Patient A1ZJ41O overall = %2.2f steps.', locate(1))
sprintf('The median of steps for Patient A1ZJ41O overall = %2.2f steps.', locate(2))
 
sprintf('The range of steps data for Patient A1ZJ41O = %2.2f steps.', stats(1))
sprintf('The standard deviation of steps data for Patient A1ZJ41O = %2.2f steps.', stats(2))



%% Patient: A36HR6Y
% Finding Measures of Central Tendency and Dispersion
% For heart-rate, steps, and sleep, relevant central tendency data is the mean and median
% For heart-rate, steps, and sleep, relevant dispersion data is the range and standard deviation,
%% HEARTRATE

Pat4hr = readtable('A36HR6Y_hr.csv');
hr = Pat4hr.heartrate;
locate = [mean(hr) median(hr)];
stats = [range(hr) std(hr)];

sprintf('The mean of heart rate for Patient A36HR6Y = %2.2f bpm.', locate(1))
sprintf('The median of heart rate for Patient A36HR6Y = %2.2f bpm.', locate(2))

sprintf('The range of heart rate data for Patient A36HR6Y = %2.2f bpm.', stats(1))
sprintf('The standard deviation of heart rate data for Patient A36HR6Y = %2.2f bpm.', stats(2))


%% SLEEP

%Following Paul's Piazza post. Will combine all non "wake" stages into one
% "sleep" category. Will add up all sleep categories, then perform central 
% tendency and dispersion calculations on that sleep data

Pat4sleep = readtable('A36HR6Y_sleep.csv');

Pat4sleep.stage(strcmp(Pat4sleep.stage,'light')) = {'sleep'};
Pat4sleep.stage(strcmp(Pat4sleep.stage,'deep')) = {'sleep'};
Pat4sleep.stage(strcmp(Pat4sleep.stage,'rem')) = {'sleep'};

%Converting seconds to hours
Pat4sleep.stage_duration = Pat4sleep.stage_duration / 3600; 

%removing all instances of wake and unused variables for retime
Pat4sleep = Pat4sleep(~any(strcmp(Pat4sleep.stage,'wake'),2),:);
Pat4sleep = Pat4sleep(~any(strcmp(Pat4sleep.stage,'awake'),2),:);
Pat4sleep = Pat4sleep(~any(strcmp(Pat4sleep.stage,'restless'),2),:);

Pat4sleep= removevars(Pat4sleep,{'user'});
Pat4sleep= removevars(Pat4sleep,{'stage'});

%summing daily sleep hours 
TT = table2timetable(Pat4sleep);
sumSleep = retime(TT, 'daily', 'sum');
%remove non-data
sumSleep(sumSleep.stage_duration==0,:) = [] ;

sleep = sumSleep.stage_duration;

locate = [mean(sleep) median(sleep)];
stats = [range(sleep) std(sleep)];

sprintf('The mean sleep time for Patient A36HR6Y = %2.2f hours.', locate(1))
sprintf('The median of sleep time for Patient A36HR6Y = %2.2f hours.', locate(2))

sprintf('The range of sleep hours for Patient A36HR6Y = %2.2f hours.', stats(1))
sprintf('The standard deviation of sleep hours for Patient A36HR6Y = %2.2f hours.', stats(2))
%% STEPS

Pat4steps = readtable('A36HR6Y_steps.csv');
Pat4steps = removevars(Pat4steps,{'user'});

%Summing the number of steps taken per day
TT = table2timetable(Pat4steps);
sumSteps = retime(TT, 'daily', 'sum');
steps = sumSteps.steps;

% Finding respective values based on daily results
locate = [mean(steps) median(steps)];
stats = [range(steps) std(steps)];

sprintf('The mean steps for Patient A36HR6Y overall = %2.2f steps.', locate(1))
sprintf('The median of steps for Patient A36HR6Y overall = %2.2f steps.', locate(2))
 
sprintf('The range of steps data for Patient A36HR6Y = %2.2f steps.', stats(1))
sprintf('The standard deviation of steps data for Patient A36HR6Y = %2.2f steps.', stats(2))



%% Patient: A4E0D03
% Finding Measures of Central Tendency and Dispersion
% For heart-rate, steps, and sleep, relevant central tendency data is the mean and median
% For heart-rate, steps, and sleep, relevant dispersion data is the range and standard deviation,
%% HEARTRATE

Pat5hr = readtable('A4E0D03_hr.csv');
hr = Pat5hr.heartrate;
locate = [mean(hr) median(hr)];
stats = [range(hr) std(hr)];

sprintf('The mean of heart rate for Patient A4E0D03 = %2.2f bpm.', locate(1))
sprintf('The median of heart rate for Patient A4E0D03 = %2.2f bpm.', locate(2))

sprintf('The range of heart rate data for Patient A4E0D03 = %2.2f bpm.', stats(1))
sprintf('The standard deviation of heart rate data for Patient A4E0D03 = %2.2f bpm.', stats(2))


%% SLEEP

%Following Paul's Piazza post. Will combine all non "wake" stages into one
% "sleep" category. Will add up all sleep categories, then perform central 
% tendency and dispersion calculations on that sleep data

Pat5sleep = readtable('A4E0D03_sleep.csv');

Pat5sleep.stage(strcmp(Pat5sleep.stage,'light')) = {'sleep'};
Pat5sleep.stage(strcmp(Pat5sleep.stage,'deep')) = {'sleep'};
Pat5sleep.stage(strcmp(Pat5sleep.stage,'rem')) = {'sleep'};

%Converting seconds to hours
Pat5sleep.stage_duration = Pat5sleep.stage_duration / 3600; 

%removing all instances of wake and unused variables for retime
Pat5sleep = Pat5sleep(~any(strcmp(Pat5sleep.stage,'wake'),2),:);
Pat5sleep = Pat5sleep(~any(strcmp(Pat5sleep.stage,'awake'),2),:);
Pat5sleep = Pat5sleep(~any(strcmp(Pat5sleep.stage,'restless'),2),:);

Pat5sleep= removevars(Pat5sleep,{'user'});
Pat5sleep= removevars(Pat5sleep,{'stage'});

%summing daily sleep hours 
TT = table2timetable(Pat5sleep);
sumSleep = retime(TT, 'daily', 'sum');
%remove non-data
sumSleep(sumSleep.stage_duration==0,:) = [] ;

sleep = sumSleep.stage_duration;

locate = [mean(sleep) median(sleep)];
stats = [range(sleep) std(sleep)];

sprintf('The mean sleep time for Patient A4E0D03 = %2.2f hours.', locate(1))
sprintf('The median of sleep time for Patient A4E0D03 = %2.2f hours.', locate(2))

sprintf('The range of sleep hours for Patient A4E0D03 = %2.2f hours.', stats(1))
sprintf('The standard deviation of sleep hours for Patient A4E0D03 = %2.2f hours.', stats(2))
%% STEPS

Pat5steps = readtable('A4E0D03_steps.csv');
Pat5steps= removevars(Pat5steps,{'user'});

%Summing the number of steps taken per day
TT = table2timetable(Pat5steps);
sumSteps = retime(TT, 'daily', 'sum');
steps = sumSteps.steps;

% Finding respective values based on daily results
locate = [mean(steps) median(steps)];
stats = [range(steps) std(steps)];

sprintf('The mean steps for Patient A4E0D03 overall = %2.2f steps.', locate(1))
sprintf('The median of steps for Patient A4E0D03 overall = %2.2f steps.', locate(2))
 
sprintf('The range of steps data for Patient A4E0D03 = %2.2f steps.', stats(1))
sprintf('The standard deviation of steps data for Patient A4E0D03 = %2.2f steps.', stats(2))



%% Correlation Between Two Seemingly Related Datasets
% Will look at patient 2: A1K5DRI since his daily steps are the highest
% coupled with his heartrate


hr = readtable('A1K5DRI_hr.csv');
steps = readtable('A1K5DRI_steps.csv');

rowsHr = ismember(hr.datetime, steps.datetime);
rowsSteps = ismember(steps.datetime, hr.datetime);

commHr = hr(rowsHr,:).heartrate;
commSteps = steps(rowsSteps,:).steps;


%relating daily heartrate to daily steps
corr = corrcoef(commHr, commSteps)


%Commented out code was original solution. Final code is the TA's approach.
%Both give similar final answers

%hrdata = readtable('A1K5DRI_hr.csv');
%hrdata = removevars(hrdata,{'user'});

%stepdata = readtable('A1K5DRI_steps.csv');
%stepdata = removevars(stepdata,{'user'});

%averaging the hourly data
%TThr = table2timetable(hrdata);
%meanHr = retime(TThr, 'hourly', 'mean');

%TTsteps = table2timetable(stepdata);
%sumSteps = retime(TTsteps, 'hourly', 'sum');

%relating daily heartrate to daily steps
%corr = corrcoef(meanHr, sumSteps);


