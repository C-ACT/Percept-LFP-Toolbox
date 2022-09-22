%% {{date} {duration hhmmss constrained..} {stimAMP constrained...[ch1 ch2]} {[ch1name ch2name]} {[boi1 boi2]} {[pw1 pw2]}}
%% same as above, but with stim specs (can union tables in script)
function [stim_Amp] = set_stim_table(file_selected,c1,c2) 

% xlabel = Date Time
% ylabel = Stimulation Amplitude (mA)
% channel names = right(1), left(2)
    %% Extract Date/ days i.e. 01-Nov-2021
    filename = load(file_selected);
    
    %retrieve the time data
    dt = filename.LFPTrendLogs.stimAmp;
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
    %(end,2).Channel  (elctrode config)
    %(end,2).SensingSetUp.FrequencyInHertz -- BOI
    %(end,2).PulsesWidthInMicroSecond -- PW in us
    %%(end,2).UpperLfpThreshold, .LowerLfpThreshold

    %%
    day_no = length(days);
    times = cell(day_no,8);

    %for each day
    for d = 1:day_no %number of days present in data set
        %date
        stim_Amp(d,1) = {days(d)}; %a string
        idx = find(string(date)==days(d));
        %times(d,2) = {dt.time(idx)}; % yields format: e.g. 01-Nov-2021 00:08:52
        
        %time of day and beta power
        stim_Amp(d,2) = {datetime(dt.time(idx), 'Format','HH:mm:ss')};% yields format: e.g. 00:08:52
        stim_Amp(d,3) = {dt.data(idx,:)}; %nx2 for 2 channels; LFP beta power 

        %% constrain time and LFP power
        %constrain times (to durations), 
        time_uc = stim_Amp{d,2};
        time_uc = duration(string(time_uc));
        ix = (time_uc>=c1) & (time_uc<=c2);
        time_c = find(ix);
        
        rawtimes = stim_Amp{d,2}(time_c); % for constrained datetime format
        rawdat = {stim_Amp{d,3}(time_c,:)}; % for conrtrained l and right channel

   % filename.ActiveGroup.NewProgramSettings.SensingChannel; for
    % settings per file --- repmat it per day
    %(1,2).Channel  (elctrode config)
    %(1,2).SensingSetUp.FrequencyInHertz -- BOI
    %(1,2).PulsesWidthInMicroSecond -- PW in us
    %%(1,2).UpperLfpThreshold, .LowerLfpThreshold


        %overwrite time and stim amp unconstrained to constrained measures
        stim_Amp(d,2) = {time_uc(time_c)}; %time constrained
        stim_Amp(d,3) = {rawdat{1}(:,1)}; %stim Amp constrained
        stim_Amp(d,4) = {rawdat{1}(:,2)};

        %Add in stim device parameters/ specs
        dtspec = filename.ActiveGroup.NewProgramSettings(end,1).SensingChannel;
        %{R,L}
        stim_Amp(d,5) = {[string(dtspec(2).Channel(27:end)),string(dtspec(1).Channel(27:end)),]}; %%%%%%%%%%%%%%%%%ASSUMING 2 CHANNELS ONLY (1) and (2)%%%%%%%%%%%%%
        stim_Amp(d,6) = {[dtspec(2).SensingSetup.FrequencyInHertz, dtspec(1).SensingSetup.FrequencyInHertz]}; %%boi
        stim_Amp(d,7) = {[dtspec(2).PulseWidthInMicroSecond, dtspec(1).PulseWidthInMicroSecond]}; %%pw
      
        stim_Amp(d,8) = {rawtimes};%constrained datetime appended;
    end
end




