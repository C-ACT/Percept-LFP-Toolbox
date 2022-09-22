%S. N. Pitts: 06-29-2022
%% Plot Index and Score for non-smoothed data
%Fluctuation Score of k wide window, non-overlapping consecutive samples or
%bins s.t. summation over k days of the IQR of LFP BP each day 
%%%%%%TO DO: INTERPOLATE REPEAT LAST KNOWN/ BLANK IQR BEFORE CALCULATING
%%%%%%FS save figures (see visOutliersBP.m for saving)
function [FS] = calcFS(T,k,logical) %default is k = 9
    %% Plot Index and Score for non-smoothed data
    %% FS and FI Edit
    FS = timetable(T.Date,T.("Date Time (HH:mm:ss)"),T.("LFP Band Power - R/CH1"),T.("LFP Band Power - L/CH2"), 'VariableNames',...
        {'Date Time (HH:mm:ss)','LFP Band Power - R/CH1','LFP Band Power - L/CH2'});
    %FI = FS;
    
    %% FS details (range, median)
    dt_r = T.("LFP Band Power - R/CH1");
    dt_l = T.("LFP Band Power - L/CH2");
    time = FS.("Time");
    
    %%RIGHT SIDE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Calculate the IQR
    tab = FS(:,2);
    func = @iqr; 
    varn = {'R_LFP Band Power IQR'};
    FS = InTableArrayCalc(tab,func,varn,FS);
    %FS = addvars(FS,range);
     
    %Calculate FS w/o overlap; dates in order
    x = FS.("R_LFP Band Power IQR");
    x = fillmissing(FS.("R_LFP Band Power IQR"),'previous'); %%EDITED
    func = movsum(x,[0 k-1]);
    fs = nan(height(FS),1);
    for i = 1:k:length(fs)
        fs(i) = func(i); %create k long bins
    end
    varn = {'R_LFP Band Power FS'};
    FS = addvars(FS,fs,'NewVariableNames',varn);
    
    %Calculate Std
    tab = FS(:,2);
    func = @std; 
    varn = {'R_LFP Band Power Std'};
    FS = InTableArrayCalc(tab,func,varn,FS);
    % FS = addvars(FS,sd);
    
    figure
    hold on
    y = fillmissing(FS.("R_LFP Band Power FS"),'previous'); %This shouldn't occur
    % given the x EDIT above
    %y = FS.("R_LFP Band Power FS");
    y = log(y);
    plot(time, y,'k');
    title('Right Side: FS')
    xlabel('time (min)')
    ylab = sprintf('FS (k=%d bins)',k);
    ylabel(ylab)
    if logical
        savefig("RightFS-Raw")
    else
        savefig("RightFS-MedicalLP")
    end
    hold off
    
    
    figure
    hold on
    plot(time, FS.("R_LFP Band Power Std"));
    title('Right Side: Std')
    ylabel('Std')
    xlabel('time (min)')
    if logical
        savefig("RightStd-Raw")
    else
        savefig("RightStd-MedicalLP")
    end    
    %%LEFT SIDE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Calculate the IQR
    tab = FS(:,3);
    func = @iqr; 
    varn = {'L_LFP Band Power IQR'};
    FS = InTableArrayCalc(tab,func,varn,FS);
    %FS = addvars(FS,range);
     
    %Calculate FS
    x = FS.("L_LFP Band Power IQR");
    x = fillmissing(FS.("L_LFP Band Power IQR"),'previous'); %%EDITED
    func = movsum(x,[0 k-1]);
    fs = nan(height(FS),1);
    for i = 1:k:length(fs)
        fs(i) = func(i); %create k long bins
    end
    varn = {'L_LFP Band Power FS'};
    FS = addvars(FS,fs,'NewVariableNames',varn);
    
    %Calculate Std
    tab = FS(:,3);
    func = @std; 
    varn = {'L_LFP Band Power Std'};
    FS = InTableArrayCalc(tab,func,varn,FS);
    % FS = addvars(FS,sd);
    
    figure
    hold on
    y = fillmissing(FS.("L_LFP Band Power FS"),'previous'); % This is done
    %with missing LFP data
    %y = FS.("L_LFP Band Power FS");
    y = log(y);
    plot(time,y,'k');
    title('Left Side: FS')
    xlabel('time (min)')
    ylab = sprintf('FS (k=%d bins)',k);
    ylabel(ylab)
    if logical
        savefig("LeftFS-Raw")
    else
        savefig("LeftFS-MedicalLP")
    end
    
    figure
    hold on
    plot(time, FS.("L_LFP Band Power Std"));
    title('Left Side: Std')
    ylabel('Std')
    xlabel('time (min)')
    if logical
        savefig("LeftStd-Raw")
    else
        savefig("LeftStd-MedicalLP")
    end
end
%% POSSIBLE TO-DO

%Linear Regression Against Different Months (30 days) 

%interpolate data to max dimensions; combine k data at a time (by parameter
%changes)

%Linear Regressions of different time periods


% multiple regression and clustering according to the tables info and
% features

%% FI
%smooth data via resampling/ LP filter (export to code)
%find peaks 

% %% Tabulate a function across arrays in a table
% function [FullTable] = InTableArrayCalc(Table,func,varn,FullTable) 
% %generate variable for table input Table or SubTable(:,n); vars is {'name of variables',...}
% 
% 
%    [row, col] = size(Table);
%     tmp = zeros(row,col)-1;
%     for i=1:row   
%        for j=1:col
%             a = Table{i,j}{1};
%             tmp(i,j) = func(a);
%        end
%     end
%     FullTable = addvars(FullTable,tmp,'NewVariableNames',varn);
% end

