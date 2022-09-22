% Structure and combine JSON files from loadJSON2.m (Percept Toolbox)
% to create a custom timeline, and features
% Without clearing the workspace

%select character of JSON files used to produce 'LFPTrenLogs'.mat files 
[filenames, data_pathname] = uigetfile('*.mat', 'MultiSelect', 'on');
filenames = cell(filenames); %create a cell array of files of interest
cd(data_pathname)

%% Initialize Variables/ Parameters
%Contrain time analysis of LFPTrendLogs
%[c1, c2] range ex: "09:00:00"
c1 = "09:00:00";
c2 = "21:00:00";

c1 = duration(c1); %format constraint into time domain
c2 = duration(c2);

%Create LFP DataFrame, T and Stimulation DataFrame, S
[T,S] = initializeFrame(c1,c2,filenames);

%% Optional Extractions
%Identify Peaks and Troughs of LFP band power data each day; 
% used prior to calculateMinMaxStatsIQR(C);
C = dailyPeaksTroughs(T);

%Calculate IQR of average and absolute minima and maxima daily LFP band
%power. Used prior to C_uniform.
C = calculateMinMaxStatsIQR(C);

%Create uniform sampling of "dates" for Fluctuation Scores, moving averages,
%etc. Used prior to statistical analysis.
C_uniform = evenIntervalDaily(C,T);

% %Calculate an estimated/non-used Fluctuation score with k = 2 and k = 30
% %sized windows
% k=2;
% approxFS1 = approxRunningFS(k,C_uniform);
% k=30;
% approxFS2 = approxRunningFS(k,C_uniform);

%% Optional LPF for L-dopa curves
% y = doMedicalLPF(x);
filename = 'structureData.mat';

%% Save workspace
save(filename,"T","S","C","C_uniform",'-mat');

