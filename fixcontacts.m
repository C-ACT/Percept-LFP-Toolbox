%% fix plot names and order
%make a copy of figure first!!!

close all

[filenames, data_pathname] = uigetfile('*.fig', 'MultiSelect', 'off');
cd(data_pathname)

h = openfig(filenames);
h = findobj(gca,'Type','line')
x = get(h,'Xdata')
y = get(h,'Ydata')
delete(h);
subplot(2,1,2)
ax = gca
yyaxis("right") %right
set(ax,'yticklabel',[])


%% edit y
subplot(2,1,2)
yyaxis right
plot(x,y(1,:),'r')
ylabel('Lead Configuration','Color','r')