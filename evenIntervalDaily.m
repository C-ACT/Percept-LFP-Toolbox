


function [C_uniform] = evenIntervalDaily(C,T)

    %% Create a times table and regulate time interval
    C = table2timetable(C,"RowTimes",T.Properties.RowTimes);
    %for interrow calculation must create interpolated or uniformly sampled
    %data with repeat values
    C_uniform = C(:,5:end);
    %data is interpolated for calculation purposes
    C_uniform = retime(C_uniform,'daily','previous'); 
end