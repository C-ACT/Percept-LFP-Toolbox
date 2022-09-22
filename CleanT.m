%% Get rid of duplicate dates and sort element in cell containing fields
function [CleanTable] = CleanT(TableT) 
%generate variable for table input Table or SubTable(:,n); vars is {'name of variables',...}

%Receive time field (dates) in this case
  CleanDates = unique(TableT.Date);
  CleanTable = TableT;

  [row, ~] = size(CleanDates);

    for i=1:row   

        %find indices of duplicate dates (or minimal time)
        % and append relevant data

        duplicates = find(CleanTable.Date==CleanDates(i));
        if length(duplicates)>1
            idx = duplicates(1);
            CleanTable(duplicates(2:end),:) = [];


            %% sort array elements in row i in each column k of CleanTable - necessary for plotting
            %chronologically
            
            %raw - same length matrices
            dur=[2 3]; %sort these columns in a new table and reassign; 
            t1=[];
           
            %Table t1: [Raw Date Time, Raw LFP ch1 bp, Raw LFP ch2 bp]
            t1 = table(CleanTable{idx,dur(1)}{1}',CleanTable{idx,dur(2)}{1}(:,1),CleanTable{idx,dur(2)}{1}(:,2));
            %sort concatenized variables for date i
            t1 = sortrows(t1);
            %reassign back to clean table (as a cell)
            rdt = [t1{:,1}];
            raw_lfp_bp = [t1{:,2},t1{:,3}];
            CleanTable{idx,dur(1)}{1} = reshape(rdt,1,[]);
            CleanTable{idx,dur(2)}{1} = reshape(raw_lfp_bp,[],2);

             %constrained
             k = [4 5 6 7]; %location (column) in CleanTable
             t2=[];
             %Table t2: [Raw LFP BP ch1, Raw LFP BP ch2,LFP BP constrained ch1, LFPconstrained ch2]
             t2 = table(CleanTable{idx,k(1)}{1}', CleanTable{idx,k(2)}{1}, CleanTable{idx,k(3)}{1},CleanTable{idx,k(4)}{1}');
             %sort concatenized variables for date i
             t2 = sortrows(t2);
            %reassign back to clean table (as a cell)
            dur_ = [t2{:,1}];
            lfp_bp_ch1 = [t2{:,2}];
            lfp_bp_ch2 = [t2{:,3}];
            cdt = [t2{:,4}];
            CleanTable{idx,k(1)}{1} = reshape(dur_,1,[]);
            CleanTable{idx,k(2)}{1} = reshape(lfp_bp_ch1,[],1);
            CleanTable{idx,k(3)}{1} = reshape(lfp_bp_ch2,[],1);
            CleanTable{idx,k(4)}{1} = reshape(cdt,1,[]);
  
        end     
    end
end


