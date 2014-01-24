%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function pilots =gen_pilots_leg(num_syms,z_start)
% generates legacy pilots
% Input :num_syms - number of symbols
%        z_start  - the symbol to start from
function pilots =gen_pilots_leg(num_syms,z_start)

% z = 0 signals
% z = 1 data legacy

PilotPolarity = [1  1 1 -1];

pilots = ones(num_syms,1)*PilotPolarity;


% need to multiply by global mask


 
%Pilot sequence 1-127 cyclic
pilot_seq =[1 1 1 1 -1 -1 -1 1 -1 -1 -1 -1 1 1 -1 1 -1 -1 1 1 -1 1 1 -1 1 1 1 1 1 1 -1 1 ...
           1 1 -1 1 1 -1 -1 1 1 1 -1 1 -1 -1 -1 1 -1 1 -1 -1 1 -1 -1 1 1 1 1 1 -1 -1 1 1 ...
           -1 -1 1 -1 1 -1 1 1 -1 -1 -1 1 1 -1 -1 -1 -1 1 -1 -1 1 -1 1 1 1 1 -1 1 -1 1 -1 1 ...
           -1 -1 -1 -1 -1 1 -1 1 1 -1 1 -1 1 1 1 -1 -1 1 -1 -1 -1 1 1 1 -1 -1 -1 -1 -1 -1 -1];

   
pilot_seq_bits = pilot_seq(1+mod(z_start+(0:num_syms-1),127));


pilots = pilots.*(pilot_seq_bits'*ones(1,4));

pilots=pilots';
pilots = pilots(:);
if (size(pilots,2)==1)
    pilots=pilots';
end