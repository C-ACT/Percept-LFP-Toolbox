%% Tabulate a function across arrays in a table
function [FullTable] = InTableArrayCalc(Table,func,varn,FullTable) 
%generate variable for table input Table or SubTable(:,n); vars is {'name of variables',...}


   [row, col] = size(Table);
    tmp = zeros(row,col)-1;
    for i=1:row   
       for j=1:col
            a = Table{i,j}{1};
            ans = func(a);
            [r,c] = size(ans);
            if r==0 || c==0
                tmp(i,j) = -1;
            else
                tmp(i,j) = ans;
            end
       end
    end
    FullTable = addvars(FullTable,tmp,'NewVariableNames',varn);
    
end