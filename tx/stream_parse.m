%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% stream parse function
%
% function bits_per_ss_i = stream_parse(bits,bspc_streams,istream)
%
% Input: bits -  input bit vector
%        bspc_streams - vector of bit per carrier per stream
%        istream - chosen stream 1-nSS
function bits_per_ss_i = stream_parse(bits,bspc_streams,istream)
bspc_streams_axis = max(bspc_streams/2,1);
sum_s = sum(bspc_streams_axis);
sum_to_stream = sum(bspc_streams_axis(1:istream-1));
npbs_i = bspc_streams_axis(istream);
% collect bits for spatial stream istream
bits_per_ss_i = bits(find((mod(0:length(bits)-1,sum_s)>=sum_to_stream) & (mod(0:length(bits)-1,sum_s)<sum_to_stream+npbs_i)));
