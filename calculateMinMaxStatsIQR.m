

function [C] = calculateMinMaxStatsIQR(C)
%Edit table C to include calculation
    
    %% Calulations Based on variables 
    
    %Avg max, abs max of R_LFPbp_, L_LFPbp (band power LFP)
    tab = C(:,1);
    func = @max;
    varn = {'R_LFP |Band Power Peak Max|'};
    C = InTableArrayCalc(tab,func,varn,C);
    
    func = @mean;
    varn = {'R_LFP Band Power Peak Avg'};
    C = InTableArrayCalc(tab,func,varn,C);
    
    
    tab = C(:,2);
    func = @max;
    varn = {'L_LFP |Band Power Peak Max|'};
    C = InTableArrayCalc(tab,func,varn,C);
    
    func = @mean;
    varn = {'L_LFP Band Power Peak Avg'};
    C = InTableArrayCalc(tab,func,varn,C);
    
    
    %Avg min, abs min of R_LFPbp_, L_LFPbp (band power LFP)
    tab = C(:,3);
    func = @min; 
    varn = {'R_LFP |Band Power Trough Min|'};
    C = InTableArrayCalc(tab,func,varn,C);
    
    func = @mean;
    varn = {'R_LFP Band Power Trough Avg'};
    C = InTableArrayCalc(tab,func,varn,C);
    
    
    tab = C(:,4);
    func = @min; 
    varn = {'L_LFP |Band Power Trough Min|'};
    C = InTableArrayCalc(tab,func,varn,C);
    
    func = @mean;
    varn = {'L_LFP Band Power Trough Avg'};
    C = InTableArrayCalc(tab,func,varn,C);
    
    
    
    %% Calculate IQR of peaks+troughs of 
    
    IQR_abs = [C.("R_LFP |Band Power Peak Max|")-C.("R_LFP |Band Power Trough Min|")...
        , C.("L_LFP |Band Power Peak Max|")-C.("L_LFP |Band Power Trough Min|")];
    C = addvars(C,IQR_abs(:,1),IQR_abs(:,2),'NewVariableNames',{'|IQR| R_LFP Power','|IQR| L_LFP Power'});
    
    IQR_avg = [C.("R_LFP Band Power Peak Avg")-C.("R_LFP Band Power Trough Avg")...
        , C.("L_LFP Band Power Peak Avg")-C.("L_LFP Band Power Trough Avg")];
    C = addvars(C,IQR_abs(:,1),IQR_abs(:,2),'NewVariableNames',{'Avg IQR R_LFP Power','Avg IQR L_LFP Power'});

end