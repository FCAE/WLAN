%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% puncturing function
% function punct_bits = puncture_bits(bits,pattern)
% input : coded bits
%         puncture patterns vector (1 retain 0 puncture)
%
function punct_bits = puncture_bits(bits,pattern)
len = length(pattern);
punct_bits = bits(find(pattern(1+mod((0:length(bits)-1),len))==1));

