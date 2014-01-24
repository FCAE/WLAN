%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function symbols_cdd = add_sts_cdd (pilot_and_data_symbols)
% adds cdd which is defined per space time stream
%

function symbols_cdd = add_sts_cdd (pilot_and_data_symbols)
global T_ISTS_TS;
nsts        =   size(pilot_and_data_symbols,3); 
symbols_cdd =   add_cdd(pilot_and_data_symbols,T_ISTS_TS(nsts,1:nsts));
