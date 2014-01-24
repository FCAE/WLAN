%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function sig_after_ifft = fd_to_td(sig,out_fft_size)
% performs upsampling by zero padding and fft + fft scale factor
% compensation
function sig_after_ifft = fd_to_td(sig,out_fft_size)
sizein=size(sig,1);
inp_to_fft = zeros(out_fft_size,size(sig,2),size(sig,3));
inp_to_fft(1:sizein/2,:,:)=sig(1:sizein/2,:,:);
inp_to_fft(out_fft_size-sizein/2+1:out_fft_size,:,:)=sig(sizein/2+1:size(sig,1),:,:);
sig_after_ifft = out_fft_size*ifft(inp_to_fft);

