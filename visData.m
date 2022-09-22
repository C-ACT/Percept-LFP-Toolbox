%%Feature Extraction and Visualization
% Summarize and compute components from DataStructure generated by
% Generate Feature Graphs/ Calculate them
% structureData.m (as 'structureData'.mat)
%% load file of interest ('structureData'.mat)
clear all 
close all
[filename, data_pathname] = uigetfile('*.mat', 'MultiSelect', 'off');
cd(data_pathname)
load(filename)

%% Date Range: %%% TO DO: exclude the pre-1st programming dates
%% Summarize stats

%Band Power Outliers of Daily Local Min and Max, and constrained raw data 
visOutliersBP(C,T)
%%
%Edit out first programming dates (at 0 Amp on either side)
R = removeFirstProgamming(S);
C_uniform = C_uniform(R,:); 
S = S(R,:);
T = T(R,:);

%%Fill in missing data for day to day calculations
%T = retime(T,'daily','previous');  -- covered in FS calc already

%%
%Calculate est fluctation score of k sized windows with overlap, image (not good for comparing to baseline)
%edit missing values in this script!!!!!!!%%%%%%%%%%%
% C_uniform = 
% k=5;
% approxRunningFS(k,C_uniform);
% plotStimRunFS(C_uniform,S,k,true);

%Calculate the fluctation score of k sized bins, image  
k=5;
%exclude the pre-first programming
FS = calcFS(T,k,true);
plotStimFS(FS,S,k,true);


%(for FI and FS) - with processed data^^^
%doMedicalLPF(x)
%% Summary
summary(T)
summary(S)
summary(C)
summary(C_uniform)
