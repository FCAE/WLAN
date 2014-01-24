%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Written in Metalink Broadband
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function []=set_mcs_string()
format=val_get('format');
if format==1
    aa=get(findobj(gcbf,'Tag','hidden_mcs_legacy'),'String');
else
    aa=get(findobj(gcbf,'Tag','hidden_mcs_ht'),'String');
end

 set(findobj(gcbf,'Tag','mcs'),'String',aa);
    
    