function dlgstruct = rootddg(h)
  
  info.Type = 'textbrowser';
  info.Text = root_info_l(h);
  info.DialogRefresh = 1;
  info.RowSpan = [1 2];
  info.ColSpan = [1 2];
  
   %%%%%%%%%%%%%%%%%%%%%%%
  % Main dialog
  %%%%%%%%%%%%%%%%%%%%%%%
  dlgstruct.DialogTitle = 'Root';
  dlgstruct.LayoutGrid = [2 2];
  dlgstruct.Items = {info};
  dlgstruct.HelpMethod  = 'helpview';
  dlgstruct.HelpArgs    = {[docroot '/mapfiles/simulink.map'], 'simulink_root'};
  
%-----------------------------------------------------------------------------
function htm = root_info_l(h),
%
%
%

m = h.find('-isa', 'Simulink.BlockDiagram','-depth', 1);
libInds = [];
openInds = [];
for i=1:length(m),
   if m(i).isLibrary,
   libInds = [libInds, i];
   end;
   h = m(i).handle;
   if isequal(get_param(h, 'Open'), 'on'),
    openInds = [openInds, i];
    end;
end;

libs = m(libInds);
openThings = m(openInds);
m(libInds) = [];

numOpenModels = length(intersect(m, openThings));
numOpenLibs   = length(intersect(libs, openThings));

	       
	str = ['<table width="100%%"  BORDER=0 CELLSPACING=0 CELLPADDING=0 bgcolor="#ededed">',...
        '<tr><td>', ...
        '<b><font size=+3>Simulink Root Information</b></font>', ...
        '<table>',...
        '<tr><td>',...
        'The Simulink Root is the top most node in the Simulink hierarchy. All ',...
        'loaded models and libraries live under the Simulink Root. Any global instances of ',...
        'Simulink data classes such as: <a href="matlab:helpview([docroot,''/mapfiles/simulink.map''], ''parameter_class'');">Parameter</a>, ',...
        '<a href="matlab:helpview([docroot,''/mapfiles/simulink.map''], ''signal_class'');">Signal</a>, or other <a href="matlab:helpview([docroot,''/mapfiles/simulink.map''], ''data_object_classes'');">data object classes</a>',...
        ' can be found in the Simulink Root''s Base Workspace node along with any valid MATLAB workspace variables.',...
        '</td></tr></table>', ...
        '<table>',...
        '<tr><td align="right"><b>Models loaded:</b></td><td>%d</td>', ...   
        '<td align="right"><b>Libraries loaded:</b></td><td>%d</td></tr>', ...   
        '<tr><td align="right"><b>Models opened:</b></td><td>%d</td>', ...   
        '<td align="right"><b>Libraries opened:</b></td><td>%d</td></tr>', ...         
       '</table>', ...
       '</td></tr>', ...
       '</table>',...
       '   <br>',...
      ... '<p>',...
       '<font size=+2><a href="matlab:preferences;">Preferences</a></font>',...
       '<p>',...
       '<table width="200%%"  BORDER=0 CELLSPACING=0 CELLPADDING=0>',...
       '<tr><td>',...
...       '<b><font size=+2>Block Diagram Session Defaults:</font></b>', ...
       '<table>',...
       '</table>', ... 
       '</td></tr>', ...
       '</table>' ...
        ];
        

 htm = sprintf(str, length(m), length(libs), numOpenModels, numOpenLibs);