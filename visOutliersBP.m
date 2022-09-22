

function [] = visOutliersBP(C,T) 
    %Summary histogram of peaks and troughs of LFP BP per day
    %% RIGHT PEAKS
    %stacked histogram of data - RIGHT, BP
    f1 = figure
    hold on
    TTimes = categorical(T.Date);
    n = height(C);
    Y = [];%data values
    x = [];%data categories
    for i = 1:n
        %refrmat table info to compatible array
            m = length(C.R_peaks{i}); %length of peaks detected
            Y = [Y,C.R_peaks{i}]; %list of all values
            xtick = repmat(TTimes(i),1,m);%list of value categories
            x = [x,xtick];
    end
    boxchart(x,Y,"Orientation","vertical","Notch","on")
    ylabel("Right Peak LFP BP")
    str = "Right Peak LFP BP";
    title(str)
    hold off
    %% RIGHT TROUGHS
    f2 = figure
    hold on
    TTimes = categorical(T.Date);
    n = height(C);
    Y = [];%data values
    x = [];%data categories
    for i = 1:n
        %refrmat table info to compatible array
            m = length(C.R_trough{i}); %length of peaks detected
            Y = [Y,C.R_trough{i}]; %list of all values
            xtick = repmat(TTimes(i),1,m);%list of value categories
            x = [x,xtick];
    end
    boxchart(x,Y,"Orientation","vertical","Notch","on")
    ylabel("Right Trough LFP BP")
    str =  "Right Trough LFP BP";
    title(str)
    hold off
    %% RAW LFP BP RIGHT
    f3 = figure
    hold on
    TTimes = categorical(T.Date);
    n = height(T);
    Y = [];%data values
    x = [];%data categories
    for i = 1:n
        %refrmat table info to compatible array
            m = length(T.("LFP Band Power - R/CH1"){i}(:,1)); %length of peaks detected
            Y = [Y;T.("LFP Band Power - R/CH1"){i}(:,1)]; %list of all values
            xtick = repmat(TTimes(i),m,1);%list of value categories
            x = [x;xtick];
    end
    boxchart(x,Y,"Orientation","vertical","Notch","on")
    ylabel("Right LFP BP")
    str = "Right LFP BP";
    title(str)
    hold off

    %% %%%%%%%%%%%%%%%%%%%%%%%%%DIRECRTIONAL%%%%%%%%%%%%%%%%%%%CHANGE%%%



    %% LEFT PEAKS
    f4 = figure
    hold on
    TTimes = categorical(T.Date);
    n = height(C);
    Y = [];%data values
    x = [];%data categories
    for i = 1:n
        %refrmat table info to compatible array
            m = length(C.L_peaks{i}); %length of peaks detected
            Y = [Y,C.L_peaks{i}]; %list of all values
            xtick = repmat(TTimes(i),1,m);%list of value categories
            x = [x,xtick];
        
    end
    boxchart(x,Y,"Orientation","vertical","Notch","on")
    ylabel("Left Peak LFP BP")
    str = "Left Peak LFP BP"
    title(str)
    hold off
    %% LEFT TROUGHS
    f5 = figure
    hold on
    TTimes = categorical(T.Date);
    n = height(C);
    Y = [];%data values
    x = [];%data categories
    for i = 1:n
        %refrmat table info to compatible array
            m = length(C.L_trough{i}); %length of peaks detected
            Y = [Y,C.L_trough{i}]; %list of all values
            xtick = repmat(TTimes(i),1,m);%list of value categories
            x = [x,xtick];
    end
    boxchart(x,Y,"Orientation","vertical","Notch","on")
    ylabel("Left Troughs LFP BP")
    str = "Left Troughs LFP BP";
    title(str)
    hold off
    %% RAW LFP BP LEFT
    f6 = figure
    TTimes = categorical(T.Date);
    n = height(T);
    Y = [];%data values
    x = [];%data categories
    for i = 1:n
        %refrmat table info to compatible array
            m = length(T.("LFP Band Power - L/CH2"){i}(:,1)); %length of peaks detected
            Y = [Y;T.("LFP Band Power - L/CH2"){i}(:,1)]; %list of all values
            xtick = repmat(TTimes(i),m,1);%list of value categories
            x = [x;xtick];
    end
    boxchart(x,Y,"Orientation","vertical","Notch","on")
    ylabel("Left LFP BP")
    str = "Left LFP BP";
    title(str)
    hold off
    
    %% Select Upload Folder
    %contain original directory location
    
    path = pwd;
    
    %create new folder location for saving
    folder1= 'RightLFPBoxPlots';
    folder2= 'LeftLFPBoxPlots';
    mkdir(folder1)
    cd(path)
    mkdir(folder2)
    
    %RIGHT: retrieve folder for figure and pipeline output upload
    newpath = [path,'/',folder1,'/'];
    cd(newpath)
    %save figures
    figure(f1)
    savefig("R_PeakLFPBP_Box.fig")
    figure(f2)
    savefig("R_TroughLFPBP_Box.fig")
    figure(f3)
    savefig("R_RawLFPBP_Box.fig")
    
    %LEFT: retrieve folder for figure and pipeline output upload
    newpath = [path,'/',folder2,'/'];
    cd(newpath)
    %save figures
    figure(f4)
    savefig("L_PeakLFPBP_Box.fig")
    figure(f5)
    savefig("L_TroughLFPBP_Box.fig")
    figure(f6)
    savefig("L_RawLFPBP_Box.fig")
    
    cd(path)

    close all
end
