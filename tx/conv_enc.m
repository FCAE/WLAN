%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function conv_enc_bits=conv_enc(inp_bits)
%  input : bits for convolutional encoder
%  outpu : bits after convolutional encoder as column

function conv_enc_bits=conv_enc(inp_bits)
if (size(inp_bits,1)==1)
    inp_bits = inp_bits';
end
outputA = mod(conv([1 0 1 1 0 1 1],inp_bits),2);
outputB = mod(conv([1 1 1 1 0 0 1],inp_bits),2);
conv_enc_bits = [outputA(1:end-6) outputB(1:end-6)]';
conv_enc_bits = conv_enc_bits(:);
