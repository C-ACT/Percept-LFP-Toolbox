
function [R,priorD] = removeFirstProgamming(S)
    %change the range of dates/stimulation
%%
    TTimes = S.Date;
    n = height(TTimes);

 %set stimulation from data into array
 %Right
    ch1 = [];%data values
    xch1 = [];%dates
    for i = 1:n
        %refrmat table info to compatible array
            m = length(S.("Stim Amp - R/CH1 (mA)"){i}); %length of peaks detected
            ch1 = [ch1,S.("Stim Amp - R/CH1 (mA)"){i}']; %list of all values
            xtick = repmat(TTimes(i),1,m);%list of value categories
            xch1 = [xch1,xtick];
    end
 %Left
    ch2 = [];%data values
    xch2 = [];%dates
    for i = 1:n
        %refrmat table info to compatible array
            m = length(S.("Stim Amp - L/CH2 (mA)"){i}); %length of peaks detected
            ch2 = [ch2,S.("Stim Amp - L/CH2 (mA)"){i}']; %list of all values
            xtick = repmat(TTimes(i),1,m);%list of value categories
            xch2 = [xch2,xtick];
    end


    %find last instance of 0 stimulation
    loc1 = find(ch1==0);
    Day1 = loc1(length(loc1));

    loc2 = find(ch2==0);
    Day2 = loc2(length(loc2));

    Day1 = datetime(xch1(Day1)); 
    Day2 = datetime(xch2(Day2));

    priorD = string(max(Day1,Day2));%choose the starting day
    startD = string(max(Day1+1,Day2+1));%choose the starting day
    endD = S.Date(length(S.Date));

    R = timerange(startD,endD,"closed");
end