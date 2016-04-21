function setLegendInfo(this)
%SETLEGENDINFO Set legendinfo 

%   Copyright 1984-2003 The MathWorks, Inc. 

lis.type = 'hggroup';
lisc(1).type = 'line';
lisc(1).props = {...
    'Color',this.Color,...
    'LineWidth',this.LineWidth,...
    'LineStyle',this.LineStyle,...
    'Marker','none',...
    'XData',[0 1],...
    'YData',[.5 .5]};
lisc(2).type = 'line';
lisc(2).props = {...
    'Color',this.Color,...
    'LineStyle','none',...
    'Marker',this.Marker,...
    'MarkerEdgeColor',this.MarkerEdgeColor,...
    'MarkerFaceColor',this.MarkerFaceColor,...
    'MarkerSize',this.MarkerSize,...
    'XData',.5,...
    'YData',.5};
lis.children = lisc;
legendinfo(this,lis);
setappdata(double(this),'LegendLegendType','line');