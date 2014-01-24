%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function symbols_cdd = add_legacy_cdd (pilot_and_data_symbols)
% adds the cdd for the legacy packet or legacy part of packet
function symbols_cdd = add_legacy_cdd (pilot_and_data_symbols)

global T_ITX_CS; %table n65
nTx =     size(pilot_and_data_symbols,3); 
symbols_cdd = add_cdd(pilot_and_data_symbols,T_ITX_CS(nTx,1:nTx));
