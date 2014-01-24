%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function bits = merge_encoders(bitsA,bitsB,bspc_streams)
% input : two column vectors of bits
% output: merge for before stream parser
function bits = merge_encoders(bitsA,bitsB,bspc_streams)
bspc_streams_axis = max(bspc_streams/2,1);
sum_s = sum(bspc_streams_axis);
bits=[reshape(bitsA,sum_s,length(bitsA)/sum_s)' reshape(bitsB,sum_s,length(bitsB)/sum_s)']';
bits= bits(:);