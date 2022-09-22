function [] = plotT(T,i,k)

    %% Plot from table T (the raw data)
    % Check chronological order of table and duplicates
    
    close all
    f1 = figure
    hold on
    Plot = table(T.("Raw Date Time (HH:mm:ss)"){i}',(T.("Raw LFP Band Power"){i}(:,1))); *****?????ACCURATE
    Plot = sortrows(Plot);
    plot(Plot.Var1,Plot.Var2)
    
    Pot = table(T.("Date Time (HH:mm:ss)"){k}',(T.("LFP Band Power - R/CH1"){k}(:,1)));
    Pot = sortrows(Pot);
    plot(Pot.Var1,Pot.Var2,'.')
    
    xlabel("duration")
    ylabel("LFP Band Power")
    title("")
    hold off

     %% Select Upload Folder
%     %contain original directory location
%     close all
%     path = pwd;
%     
%     %create new folder location for saving
%     folder1= 'Right';
%     folder2= 'Left';
%     mkdir(folder1)
%     cd(path)
%     mkdir(folder2)
%     
%     %RIGHT: retrieve folder for figure and pipeline output upload
%     newpath = [path,folder1,'/'];
%     cd(newpath)
%     %save figures
%     f1
%     savefig()
%     f2
%     savefig()
%     f3
%     savefig()
%     
%     %LEFT: retrieve folder for figure and pipeline output upload
%     newpath = [path,folder2,'/'];
%     cd(newpath)
%     %save figures
%     f4
%     savefig()
%     f5
%     savefig()
%     f6
%     savefig()
%     
%     cd(path)
% 
%     close all

end