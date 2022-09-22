%S. N. Pitts: 06-08-2022
function [] = plotStimRunFS(C_uniform,S,k,logical)
close all

    
    %summary(C_uniform)
    
    % figure
    % hold on
    % Peak_Power = [C.R_peaks{:}];
    % histogram(Peak_Power)
    % xlabel('Power')
    % ylabel('Quantity')
    % title('All Beta Power Peaks, Right')
    % hold off
    
    % figure 
    % Peak_Power = [C.L_peaks{:}];
    % histogram(Peak_Power)
    % xlabel('Power')
    % ylabel('Quantity')
    % title('All Beta Power Peaks, Left')
    % hold off
    
    % figure
    % hold on
    % Trough_Power = [C.R_trough{:}];
    % histogram(Trough_Power)
    % xlabel('Power')
    % ylabel('Quantity')
    % title('All Beta Power Troughs, Right')
    % hold off
    
    
    % figure
    % Trough_Power = [C.L_trough{:}];
    % histogram(Trough_Power)
    % xlabel('Power')
    % ylabel('Quantity')
    % title('All Beta Power Troughs, Left')
    % hold off
    
    %% Right Data
    figure
    subplot(2,1,1)
    hold on
    yyaxis left
    plot(C_uniform.Time,C_uniform.("Daily Avg R_LFP FS"))
    xlabel('Time')
    ylab = sprintf('Running FS (k=%d window size)',k);
    ylabel(ylab)
    
    yyaxis right
    right = [S.("Band of Interest (Hz)"){:}];
    right = right(1:2:end);
    plot(S.Date,right)
    ylabel('Band of Interest (Hz)')
    
    title('Daily Avg R_LFP FS')
    hold off
    
    subplot(2,1,2)
    hold on
    yyaxis left
    stimx = [S.("Date Time (HH:mm:ss)"){:}];
    stimy = [];
    for i = 1:length(S.("Stim Amp - R/CH1 (mA)"))
        stimy = [stimy;(S.("Stim Amp - R/CH1 (mA)"){i})];
    end
    scatter(stimx,stimy')
    ylabel('Stim Amp (mA)')
    
    yyaxis right
    cla
    right = [S.("Channel Names"){:}];
    right = right(1:2:end);
    cat = unique(right);
    y=zeros(1,length(right));
    %create categorical array
    for i = 1:length(cat)
        idx = find(right==cat(i));
        y(idx) = i;
    end
    c = categorical(y,1:length(cat),[cat]);
    right = [S.("Channel Names"){:}];
    right = right(1:2:end);
    plot(S.Date,c)
    ylabel('Lead Configuration')
    
    title('Stimulation and Channels')
    hold off
    if logical
        savefig("RightRunFS-Raw")
    else
        savefig("RightRunFS-MedicalLP")
    end
    
    %% Left Data
    figure
    subplot(2,1,1)
    hold on
    yyaxis left
    plot(C_uniform.Time,C_uniform.("Daily Avg L_LFP FS"))
    xlabel('Time')
    ylab = sprintf('Running FS (k=%d window size)',k);
    ylabel(ylab)
    
    yyaxis right
    left = [S.("Band of Interest (Hz)"){:}];
    left = left(1:2:end);
    plot(S.Date,left)
    ylabel('Band of Interest (Hz)')
    
    title('Daily Avg L_LFP FS')
    hold off
    
    subplot(2,1,2)
    hold on
    yyaxis left
    stimx = [S.("Date Time (HH:mm:ss)"){:}];
    stimy = [];
    for i = 1:length(S.("Stim Amp - L/CH2 (mA)"))
        stimy = [stimy;(S.("Stim Amp - L/CH2 (mA)"){i})];
    end
    scatter(stimx,stimy')
    ylabel('Stim Amp (mA)')
    
    yyaxis right
    cla
    left = [S.("Channel Names"){:}];
    left = left(1:2:end);
    cat = unique(left);
    y=zeros(1,length(left));
    %create categorical array
    for i = 1:length(cat)
        idx = find(left==cat(i));
        y(idx) = i;
    end
    c = categorical(y,1:length(cat),[cat]);
    left = [S.("Channel Names"){:}];
    left = left(1:2:end);
    plot(S.Date,c)
    ylabel('Lead Configuration')
    
    title('Stimulation and Channels')
    hold off
    if logical
        savefig("LeftRunFS-Raw")
    else
        savefig("LeftRunFS-MedicalLP")
    end

end
