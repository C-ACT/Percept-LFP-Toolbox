


%sort the confined data (cells within) timetable
function [OrderedTable] = SortT(TableT)
    OrderedTable = TableT;
    for i = 1:height(TableT)
        %create temporary table
        tmp = table(TableT{i,3}{1}',TableT{i,4}{1},TableT{i,5}{1},TableT{i,6}{1}'); %sort constraint duration power, datetime
        
        tmp = sortrows(tmp);

        %assign sorted vectors
        OrderedTable{i,3} = {tmp{:,1}};
        OrderedTable{i,4} = {tmp{:,2}};
        OrderedTable{i,5} = {tmp{:,3}};
        OrderedTable{i,6} = {tmp{:,4}};
        
        %Check 
        %TableT
    end
end
