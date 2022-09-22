%% times is {{date} {times in hour...} {LFP beta power values..[ch1 ch2]} {duration constrained} {LFP beta power constrained}}
function [times] = set_table(file_selected,c1,c2) 
% xlabel = Date Time
% ylabel = LFP band power ?????????UNITS DB?????????????
% channel names = right(1), left(2)    
 %% Extract Date/ days i.e. 01-Nov-2021
    filename = load(file_selected);
    
    %retrieve the time data
    dt = filename.LFPTrendLogs.LFP;
    date = datetime(dt.time, 'Format','dd-MMM-uuuu');
    %stream_start_date = dt.time(1); %can use this for dates
    days = unique(string(date)); %number of days present
    
    %% Set day = []
    day = datetime(days,'InputFormat','dd-MMM-uuuu');
    %% Set times (extract data) - i.e.
    % parce through the date and assign a cell of those raw times: cell with
    %size (days x 3), in which column 1 = days and column 2 = time values,
    %column 3 = LFP beta power values, 4 = time_c, 5 = LFP_c
    %assigned to each day

    %% To Do: 
    % add day column to duration (for time vector)
    % filename.ActiveGroup.NewProgramSettings.SensingChannel; for
    % settings per file --- repmat it per day
    
    day_no = length(days);
    times = cell(day_no,7);

    %for each day
    for d = 1:day_no %number of days present in data set
        %date
        times(d,1) = {days(d)}; %a string
        idx = find(string(date)==days(d));
        %times(d,2) = {dt.time(idx)}; % yields format: e.g. 01-Nov-2021 00:08:52
        
        %time of day and stim
        tmp = string(datetime(dt.time(idx), 'Format','HH:mm:ss'));
        times(d,2) = {datetime(tmp, 'InputFormat','HH:mm:ss')};
        %break
        %times(d,2) = {datetime(dt.time(idx), 'Format','HH:mm:ss')};% yields format: e.g. 00:08:52
        times(d,3) = {dt.data(idx,:)}; %nx2 for 2 channels
   
        %% constrain time and stim AMP
        %constrain times (to durations), 
        time_uc = times{d,2};

        time_uc = duration(tmp);
  %time_uc = duration(string(time_uc));
        ix = (time_uc>=c1) & (time_uc<=c2);
        time_c = find(ix);
        times(d,4) = {time_uc(time_c)}; %time constrained


        rawdat = {times{d,3}(time_c,:)}; % for conrtrained l and right channel

        times(d,5) = {rawdat{1}(:,1)}; %LFP values constrained
        times(d,6) = {rawdat{1}(:,2)}; %LFP values constrained

        
        times(d,7) = {times{d,2}(time_c)};%constrained datetime appended
         
    end
end


