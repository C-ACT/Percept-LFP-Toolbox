%generate variable for table input Table or SubTable(:,n); vars is {'name of variables',...}
function [CleanTable] = CleanS(TableS) 

%Receive time field (dates) in this case
  CleanDates = unique(TableS.Date);
  CleanTable = TableS;

  [row, ~] = size(CleanDates);

    for i=1:row   %parse through each unique date

        %find indices of duplicate dates (or minimal time)
        % and append relevant data

        duplicates = find(CleanTable.Date==CleanDates(i));

       %duplicate dates present
        if length(duplicates)>1 
            idx = duplicates(1);
            for j = 2:length(duplicates)
                 %append the data for duplicate data
                 for k = [2 8]
                    CleanTable{idx,k}{1} = horzcat(CleanTable{idx,k}{1},CleanTable{j,k}{1});
                 end
                 for k = [3 4]
                    CleanTable{idx,k}{1} = vertcat(CleanTable{idx,k}{1},CleanTable{j,k}{1});
                 end
            end
            CleanTable(duplicates(2:end),:) = [];%set location of duplicates to empty
        end     
    end
end


