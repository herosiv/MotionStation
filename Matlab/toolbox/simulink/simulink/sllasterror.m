function errs=sllasterror(newErrs)
%SLLASTERROR Simulink last error message.
%   SLLASTERROR by itself returns a Simulink diagnostic structure array
%   containing the last error(s) generated by Simulink.  The fields of
%   the diagnostic structure are:
%
%     Type        'error'
%     MessageID   the message ID for the error (e.g., 'SL_InvSimulinkObjectName')
%     Message     the error message
%     Handle      Simulink object handle(s) associated with the error
%
%   SLLASTERROR([]) resets the Simulink last error so that it will return
%   an empty array until the next Simulink error is encountered.
%
%   SLLASTERROR(DIAGSTRUCT) will set the Simulink last error(s) to those
%   specified in the DIAGSTRUCT.
%   
%   See also SLLASTDIAGNOSTIC, SLLASTWARNING.

%   Copyright 1990-2002 The MathWorks, Inc.
%   $Revision: 1.5 $

%
% if no input args, return the last error, otherwise, set it
%
if nargin == 0,
  
  %
  % the last error is the last diagnostic less the warnings
  %
  errs = sllastdiagnostic;
  if ~isempty(errs),
    warns = find(strcmp({ errs(:).Type },'warning'));
    errs(warns) = [];
  end
  
else
  
  %
  % make sure that only errors are being set
  %
  if ~isempty(newErrs),
    if ~all(strcmp({ newErrs(:).Type }, 'error')),
      error('Type field of the Simulink diagnostic structure array must be ''error''.');
    end
  end
  
  %
  % setting the last error requires that the last warnings
  % are preserved
  %
  warns = sllastwarning;
  sllastdiagnostic([warns; newErrs]);
  
end