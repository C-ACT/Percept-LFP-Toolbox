%S. N. Pitts: 07-06-2022
function [] = plotStimFS(FS,S,k,logical)
%TRUE if raw data used
%FS is logged
%https://www.mathworks.com/matlabcentral/answers/414034-plotting-a-box-plot-and-a-time-series-on-the-same-graph-as-a-distribution-over-time-boxplot-resha
    %% Plot configuration and basic descriptors
    close all
    %post deleted and interpolated data
    
    %Table in workspace:
    %FS (score related fluctuation index)
    %Programs previously ran: AverageStimAmp.m, Flux.m
    
    time = FS.("Time"); 
    
    %% Right Data
    figure
    subplot(2,1,1)
    hold on
    yyaxis left
        
    y = fillmissing(FS.("R_LFP Band Power FS"),'previous');
    %y = FS.("R_LFP Band Power FS");
    y = log(y);
    plot(time, y,'k');
    title('Right Side: FS')
    xlabel('time (min)')
    ylab = sprintf('FS (k=%d bins)',k);
    ylabel(ylab)
    Right_FS = y;
    
    yyaxis right
    right = [S.("Band of Interest (Hz)"){:}];
    right = right(1:2:end);
    plot(S.Date,right)
    ylabel('Band of Interest (Hz)')
    
    title('LFP_R_i_g_h_t FS')
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
    
    title('Right Hemisphere Stimulation and Channels')
    hold off

    if logical
        savefig("RightStimFS-Raw")
    else
        savefig("RightStimFS-MedicalLP")
    end

    %% Right BoxChart
    figure
    hold on
    TTimes = categorical(FS.("Time"));
    n = height(FS);
    Y = [];%data values
    x = [];%data categories
    for i = 1:n
        %refrmat table info to compatible array
            m = height(FS.('LFP Band Power - R/CH1'){i}); %length of peaks detected
            Y = [Y;FS.('LFP Band Power - R/CH1'){i}]; %list of all values
            xtick = repmat(TTimes(i),m,1);%list of value categories
            x = [x;xtick];
    end
    boxchart(x,log(Y),"Orientation","vertical","Notch","on") %%LOG REMOVED
    ylabel("Right LFP BP")
    str = "Right LFP BP";
    title(str)
    hold off
    savefig('RightLFPBoxCharts')

    %% RIGHT LFP BOXCHART OVERLAY
    figure
    hold on
  
    %%LEAD CONFIG
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
    
    title('Right Hemisphere Stimulation and Channels')
    hold off

    %%BOI
    yyaxis right
    right = [S.("Band of Interest (Hz)"){:}];
    right = right(1:2:end);
    plot(S.Date,right)
    ylabel('Band of Interest (Hz)')
    
    title('LFP_R_i_g_h_t FS')
    hold off
   
        savefig("RightParams")
 
    %%BOXCHART HERE
    %calc x and y
    TTimes = categorical(FS.("Time"));
    n = height(FS);
    Y = [];%data values
    x = [];%data categories
    for i = 1:n
        %refrmat table info to compatible array
            m = height(FS.('LFP Band Power - R/CH1'){i}); %length of peaks detected
            Y = [Y;FS.('LFP Band Power - R/CH1'){i}]; %list of all values
            xtick = repmat(TTimes(i),m,1);%list of value categories
            x = [x;xtick];
    end
   Right_LFP = Y;



   %plot the boxchart
   figure
   hold on
   b = tiledlayout(1,1)
   ax1 = axes(b);
   boxchart(x,log(Y),"Orientation","vertical","Notch","on","MarkerSize",2,"BoxFaceColor",'b') %%LOG REMOVED
   ax1.YAxisLocation ='right';
  
 
    %%STIMULATION
    %stimx = [S.("Date Time (HH:mm:ss)"){:}];
    stimx = S.("Date");
    stimy = [];
    x=[];
    for i = 1:length(S.("Stim Amp - R/CH1 (mA)"))
        m=height(S.("Stim Amp - R/CH1 (mA)"){i});
        stimy = [stimy;(S.("Stim Amp - R/CH1 (mA)"){i})];
        xtick = repmat(stimx(i),m,1);%list of value categories
        x = [x;xtick];
    end

    stim = table(x,stimy);
    
    hold on

    %plot stim with axes settings
    ax2 = axes(b);
    stairs(stim.("x"),stim.("stimy"),'r','LineWidth',.7,'LineStyle','--')
    ax2.XAxisLocation = 'top';
    ax2.YAxisLocation = 'left';
    ax2.Color = 'none';
    ax1.Box = 'off';
    ax2.Box = 'off';

    ax2.YColor = 'r';
    ax1.YColor = 'b';

    ax1.YLabel.String = 'LFP Band Power';
    ax2.YLabel.String = 'Stimulation (mA)';

    enableDefaultInteractivity(ax1)
    enableDefaultInteractivity(ax2)
    
    title("Right: BrainSense Timeline")

    if logical
        savefig("RightStimIQR-Raw")
    else
        savefig("RightStimIQR-MedicalLP")
    end

    %% Left Data
    figure
    subplot(2,1,1)
    hold on
    yyaxis left
    
    y = fillmissing(FS.("L_LFP Band Power FS"),'previous');
    %y = FS.("L_LFP Band Power FS");
    y = log(y);
    plot(time, y,'k');
    title('Left Side: FS')
    xlabel('time (min)')
    ylab = sprintf('FS (k=%d bins)',k);
    ylabel(ylab)

    Left_FS = y;
    
    yyaxis right
    left = [S.("Band of Interest (Hz)"){:}];
    left = left(2:2:end); %%%%%%%%%%%%%%%%
    plot(S.Date,left)
    ylabel('Band of Interest (Hz)')
    title('LFP_L_e_f_t FS')
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
    left = left(2:2:end); %%%%%%%
    cat = unique(left);
    y=zeros(1,length(left));
    %create categorical array
    for i = 1:length(cat)
        idx = find(left==cat(i));
        y(idx) = i;
    end
    c = categorical(y,1:length(cat),[cat]);
    left = [S.("Channel Names"){:}];
    left = left(2:2:end); %%%%%%%%%%
    plot(S.Date,c)
    ylabel('Lead Configuration')
    
    title('Left Hemisphere Stimulation and Channels')
    hold off
    if logical
        savefig("LeftStimFS-Raw")
    else
        savefig("LeftStimFS-MedicalLP")
    end

    %% Left Boxchart
    figure
    hold on
    TTimes = categorical(FS.("Time"));
    n = height(FS);
    Y = [];%data values
    x = [];%data categories
    for i = 1:n
        %refrmat table info to compatible array
            m = height(FS.('LFP Band Power - L/CH2'){i}); %length of peaks detected
            Y = [Y;FS.('LFP Band Power - L/CH2'){i}]; %list of all values
            xtick = repmat(TTimes(i),m,1);%list of value categories
            x = [x;xtick];
    end
    boxchart(x,log(Y),"Orientation","vertical","Notch","on") %%LOG REMOVED
    ylabel("Left LFP BP")
    str = "Left LFP BP";
    title(str)
    hold off
    savefig('LeftLFPBoxChart')

    %% LFP BOXCHART OVERLAY
    figure
    hold on

    %%LEAD CONFIG
    left = [S.("Channel Names"){:}];
    left = left(2:2:end); %%%%%%%
    cat = unique(left);
    y=zeros(1,length(left));
    %create categorical array
    for i = 1:length(cat)
        idx = find(left==cat(i));
        y(idx) = i;
    end
    c = categorical(y,1:length(cat),[cat]);
    left = [S.("Channel Names"){:}];
    left = left(2:2:end); %%%%%%%%%%
    plot(S.Date,c)
    ylabel('Lead Configuration')
    
    title('Left Hemisphere Stimulation and Channels')
    hold off

    %%BOI
    yyaxis right
    left = [S.("Band of Interest (Hz)"){:}];
    left = left(2:2:end); %%%%%%%%%%%%%%%%
    plot(S.Date,left)
    ylabel('Band of Interest (Hz)')
    title('LFP_L_e_f_t FS')
    hold off

    %%BOXCHART HERE
    %calc x and y
    TTimes = categorical(FS.("Time"));
    n = height(FS);
    Y = [];%data values
    x = [];%data categories
    for i = 1:n
        %refrmat table info to compatible array
            m = height(FS.('LFP Band Power - L/CH2'){i}); %length of peaks detected
            Y = [Y;FS.('LFP Band Power - L/CH2'){i}]; %list of all values
            xtick = repmat(TTimes(i),m,1);%list of value categories
            x = [x;xtick];
    end
   
    savefig("LeftParams")

    Left_LFP = Y;

   %plot the boxchart
   figure
   b = tiledlayout(1,1)
   ax1 = axes(b);
   boxchart(x,log(Y),"Orientation","vertical","Notch","on","MarkerSize",2,"BoxFaceColor",'b') %%%%LOG REMOVED
   ax1.YAxisLocation ='right';
  
 
    %%STIMULATION
    %stimx = [S.("Date Time (HH:mm:ss)"){:}];
    stimx = S.("Date");
    stimy = [];
    x=[];
    for i = 1:length(S.("Stim Amp - L/CH2 (mA)"))
        m=height(S.("Stim Amp - L/CH2 (mA)"){i});
        stimy = [stimy;(S.("Stim Amp - L/CH2 (mA)"){i})];
        xtick = repmat(stimx(i),m,1);%list of value categories
        x = [x;xtick];
    end

    stim = table(x,stimy);
    
    hold on

    %plot stim with axes settings
    ax2 = axes(b);
    stairs(stim.("x"),stim.("stimy"),'r','LineWidth',.7,'LineStyle','--')
    ax2.XAxisLocation = 'top';
    ax2.YAxisLocation = 'left';
    ax2.Color = 'none';
    ax1.Box = 'off';
    ax2.Box = 'off';

    ax2.YColor = 'r';
    ax1.YColor = 'b';

    ax1.YLabel.String = 'LFP Band Power';
    ax2.YLabel.String = 'Stimulation (mA)';

    enableDefaultInteractivity(ax1)
    enableDefaultInteractivity(ax2)

   
    title("Left: BrainSense Timeline")

    if logical
        savefig("LeftStimIQR-Raw")
    else
        savefig("LeftStimIQR-MedicalLP")
    end

    %% Left and Right Hemisphere Comparison
    figure 
    hold on

    Hemisphere_Names = [repmat(1,1,length(Left_FS)),repmat(2,1,length(Right_FS))];
    Hemisphere_Values = [Left_FS;Right_FS];

    Order = {'Left','Right'};
    Hemisphere_Names = categorical(Hemisphere_Names,[1, 2], Order);

    boxchart(Hemisphere_Names,log(Hemisphere_Values),'GroupByColor', Hemisphere_Names,"Notch","on")
    ylabel("LFP BP")
    legend

    str = "Left and Right LFP FS";
    title(str)
    hold off
    savefig('FSBoxChartSummary-LOG')

    %LFP Band Power
    figure 
    hold on

    Hemisphere_Names = [repmat(1,1,length(Left_LFP)),repmat(2,1,length(Right_LFP))];
    Hemisphere_Values = [Left_LFP;Right_LFP];

    Order = {'Left','Right'};
    Hemisphere_Names = categorical(Hemisphere_Names,[1, 2], Order);

    boxchart(Hemisphere_Names,log(Hemisphere_Values),'GroupByColor', Hemisphere_Names,"Notch","on")
    ylabel("LFP BP")
    legend

    str = "Left and Right LFP BP";
    title(str)
    hold off
    savefig('LFPBPBoxChartSummary-LOG')
 
% 
 end