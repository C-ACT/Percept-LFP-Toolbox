%%Create a frame that categorizes the 
% Constrain analysis frame of interest to times [c1,c2] s.t. c = "hh:MM:ss"

function [T,S] = initializeFrame(c1,c2,filenames)
    
    %format constraint into time
    c1 = duration(c1); 
    c2 = duration(c2);
    
%     stream_start_date = []; %time object, starting trend log date
%     %days = 0; %time interval: cumulative days elapsed from starting trend log date starting with day 0
%     
%     day=[]; times=[]; times_c=[]; duration_c=[]; bp_c=[]; IQR_c=[]; Q1_c=[]; Q2_c=[]; Q3_c=[];
%     boi=[]; pw=[]; stim_amp=[]; active_group=[]; ag_time=[]; meds=[];
%     
%     ag_names="";
    
    %Initialize LFP Table
    t = set_table(filenames{1},c1,c2); %see function
    for l = 2:length(filenames)
        t = vertcat(t,set_table(filenames{l},c1,c2));
    end
    T = array2table(t,...
        'VariableNames',{'Date','Raw Date Time (HH:mm:ss)','Raw LFP Band Power',...
        'Duration (HH:mm:ss)','LFP Band Power - R/CH1','LFP Band Power - L/CH2','Date Time (HH:mm:ss)'}); %latter 3 variables are constrained
    
    %Initialize Stimulation Setting Table
    s = set_stim_table(filenames{1},c1,c2); %see function
    for l = 2:length(filenames)
        s = vertcat(s,set_stim_table(filenames{l},c1,c2));
    end
    S = array2table(s,...
        'VariableNames',{'Date','Duration (HH:mm:ss)','Stim Amp - R/CH1 (mA)','Stim Amp - L/CH2 (mA)',...
        'Channel Names','Band of Interest (Hz)','Pulsewidth (µs)','Date Time (HH:mm:ss)'}); %variables are all constrained
    
    
    %% Sort Table, convert data to timetable, Eliminate Duplicate entries
    %Format T dates into Datetime format
    T.Date = datetime([T.Date{:}]', 'Format','dd-MMM-uuuu');
    
    %getting rid of duplicate days, to timetable, sort dates chronologically,
    % sort fields chronologically
    T = CleanT(T);
    T = table2timetable(T,'RowTimes','Date');
    save('Table.mat','T','-mat')
    T = sortrows(T);
    T = SortT(T); %%EDITED 07/07/2022
    
    S.Date = datetime([S.Date{:}]', 'Format','dd-MMM-uuuu');
    
    %getting rid of duplicate days, to timetable, sort dates chronologically
    S = CleanS(S);
    S = table2timetable(S,'RowTimes','Date') ;
    S = sortrows(S);
end