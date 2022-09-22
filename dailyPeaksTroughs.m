%Enter table with structure of intializeFrame.m table T
%List values of daily max and minima of raw LFP band power 
function [C] = dailyPeaksTroughs(T)

    %% Calculate Peaks - per day (c1 to c2)
    [rows,~] = size(T);
    L_peaks = cell(rows,1);
    R_peaks = L_peaks;
    
    for i = 1:rows
    
         %%%%%%%%%%%%%%% sanity check%%%%%%%%%%%%%%
    %      if mod(i,163) == 0
    %       figure
    %       findpeaks(T.("LFP Band Power - R/CH1"){i,1}) %a check to every____th figure
    %       hold off
    %      end
    
         %%%%%%%%%%%%%%% sanity check%%%%%%%%%%%%%%
    
         R_peaks{i} = findpeaks(T.("LFP Band Power - R/CH1"){i,1})';
         L_peaks{i} = findpeaks(T.("LFP Band Power - L/CH2"){i,1})';
    
    end
    
    
    %% Troughs - per day (c1 to c2)
    
    [rows,~] = size(T);
    L_trough = cell(rows,1);
    R_trough = L_trough;
    
    for i = 1:rows
    
         %%%%%%%%%%%%%%% sanity check%%%%%%%%%%%%%%
    %      if mod(i,163) == 0
    %       figure
    %       findpeaks(-T.("LFP Band Power - R/CH1"){i,1}) %a check to every _163__th figure
    %       hold off
    %      end
         %%%%%%%%%%%%%%% sanity check%%%%%%%%%%%%%%
    
         R_trough{i} = -1*findpeaks(-T.("LFP Band Power - R/CH1"){i,1})';
         L_trough{i} = -1*findpeaks(-T.("LFP Band Power - L/CH2"){i,1})';
    
    end
    
    C = table(R_peaks,L_peaks,R_trough,L_trough); 

end
