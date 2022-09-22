%approximate the FS by summing IQR of k wide moving windows
function [] = approxRunningFS(k,C_uniform) 
   %%Fill missing values
  
   C_uniform.("|IQR| R_LFP Power") = fillmissing(C_uniform.("|IQR| R_LFP Power"),'previous');
   C_uniform.("|IQR| L_LFP Power") = fillmissing(C_uniform.("|IQR| L_LFP Power"),'previous');
   C_uniform.("Avg IQR R_LFP Power") = fillmissing(C_uniform.("Avg IQR R_LFP Power"),'previous');
   C_uniform.("Avg IQR L_LFP Power") = fillmissing(C_uniform.("Avg IQR L_LFP Power"),'previous');



    %% When days are interpolated in a Times Table: Flux Score Per Day (2), k, per month (~30)
    FS = movsum(C_uniform.("|IQR| R_LFP Power"),k); 
    C_uniform = addvars(C_uniform,FS,'NewVariableNames',{'Daily Abs R_LFP FS'});
    
    FS = movsum(C_uniform.("|IQR| L_LFP Power"),k);
    C_uniform= addvars(C_uniform,FS,'NewVariableNames',{'Daily Abs L_LFP FS'});
    
    FS = movsum(C_uniform.("Avg IQR R_LFP Power"),k);
    C_uniform = addvars(C_uniform,FS,'NewVariableNames',{'Daily Avg R_LFP FS'});
    
    FS = movsum(C_uniform.("Avg IQR L_LFP Power"),k);
    C_uniform = addvars(C_uniform,FS,'NewVariableNames',{'Daily Avg L_LFP FS'});

end