%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function  write_bits (bits)
% writes bits to file grouped to bytes
function  write_bits (bits)

bitgroup = reshape(bits,8,length(bits)/8)'; % resahpe to bytes
bytes = bitgroup*(2.^(0:7)'); 

fid = fopen ('bits.hex','wt');
fprintf(fid,'%02x\n',bytes); % appends all words
fclose(fid);
