%LOADJSON loads JSON files, extracts, saves and plots BrainSense, Setup, 
%Survey, Indefinite Streaming and Timeline data in one folder per session
%Yohann Thenaisie 02.09.2020 - Lausanne University Hospital (CHUV)
%EDIT: Load TrendLogs only
%ADAPTED BY: S.N. PITTS

%% Set pathname to the Percept Toolbox
%addpath(genpath('C:\Users\BSI\Dropbox (NeuroRestore)\Percept\PerceptToolbox'))

%% Select JSON files to load
[filenames, data_pathname] = uigetfile('*.json', 'MultiSelect', 'on');
cd(data_pathname)


nFiles = size(filenames, 2);
%[row,column] = size(nFiles); %For Singular File
for fileId = 1:nFiles%row
    
    %Load JSON file
    if iscell(filenames)
        fname = filenames{fileId};
    else
        fname = filenames(fileId, :);
    end

    data = jsondecode(fileread(fname));
    
    %Create a new folder per JSON file
    params.fname = fname;
    params.SessionDate = regexprep(data.SessionDate, {':', '-'}, {''});
    params.save_pathname = [data_pathname filesep params.SessionDate(1:end-1)];
    mkdir(params.save_pathname)
    params.correct4MissingSamples = false; %set as 'true' if device synchronization is required
    params.ProgrammerVersion = data.ProgrammerVersion;

    if isfield(data, 'DiagnosticData') && isfield(data.DiagnosticData, 'LFPTrendLogs') %Timeline and Events
        
        params.recordingMode = 'LFPTrendLogs';
        extractTrendLogs(data, params)
        
    end
    
end
