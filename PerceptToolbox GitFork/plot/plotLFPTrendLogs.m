function h = plotLFPTrendLogs(LFPTrendLogs, ActiveGroup)
%Plot LFP band power and stimulation amplitude accross time from LFPTrendLogs
%Bart Keulen and Yohann Thenaisie 05.10.2020

LFP = LFPTrendLogs.LFP;
stimAmp = LFPTrendLogs.stimAmp;

h = figure;
ax = gobjects(LFP.nChannels+1, 1);
for channelId = 1:LFP.nChannels
    
    ax(channelId) = subplot(LFP.nChannels+1,1,channelId);
    yyaxis left; plot(LFP.time, LFP.data(:,channelId)); ylabel(LFP.ylabel)
    yyaxis right; plot(stimAmp.time,stimAmp.data(:,channelId)); ylabel(stimAmp.ylabel); ylim([0 max(stimAmp.data(:,channelId))+0.5])
    title(LFP.channel_names(channelId));
    
    if isfield(LFPTrendLogs, 'events')
        hold on
        
        %discard events that have been marked out of the LFP recording period
        events = LFPTrendLogs.events(LFPTrendLogs.events.DateTime > LFPTrendLogs.LFP.time(1) & LFPTrendLogs.events.DateTime < LFPTrendLogs.LFP.time(end), :);
        
        %Plot all events of each type at once
        eventIDs = unique(events.EventID);
        nEventIDs = size(eventIDs, 1);
        colors = lines(nEventIDs);
        for eventId = 1:nEventIDs
            event_DateTime = events.DateTime(events.EventID == eventIDs(eventId));
            yyaxis left; plot([event_DateTime event_DateTime], [0 max(LFP.data(:,channelId))], '--', 'Color', colors(eventId, :));
        end
        
        %Plot legend for events - to be worked on
        lgd = legend(unique(events.EventName));
        title(lgd,'Events');
    end
    
end

%Last subplot displays ActiveGroups
ax(LFP.nChannels+1) = subplot(LFP.nChannels+1,1,LFP.nChannels+1);
hold on
ActiveGroup.NewGroupId = categorical(ActiveGroup.NewGroupId);
groupNames = unique(ActiveGroup.NewGroupId);
color = {'r', 'g', 'b', 'y'};
nGroupChanges = size(ActiveGroup, 1);
for groupChange = 1:nGroupChanges
    groupId = ActiveGroup.NewGroupId(groupChange) == groupNames;
    if groupChange == nGroupChanges
        stopGroup = LFPTrendLogs.LFP.time(end);
    else
        stopGroup = ActiveGroup.DateTime(groupChange+1);
    end
    area([ActiveGroup.DateTime(groupChange), stopGroup],[1, 1],'facecolor',color{groupId}, ...
        'facealpha', 0.2,'edgecolor','none');
end
title('Active Group')
ax(LFP.nChannels+1).YAxis.Visible = 'off';

xlabel(LFP.xlabel);
linkaxes(ax, 'x')
%xlim([min(LFP.time) max(LFP.time)])
% sgtitle({'LFP Trend Logs', regexprep(LFPTrendLogs.json(1:end-5),'_',' ')})