%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function td_sig = add_cp(fft_out,shortgi)
% input samples  nfft x nsym x nTx
%       shortgi  0 = normal
%                1 = short
%                2 = double cp and double symbol
function td_sig = add_cp(fft_out,shortgi)
nfft = size(fft_out,1);
nTx =  size(fft_out,3);
nsym = size(fft_out,2);

if (shortgi==2) % This is the preamble. single symbol double cp
    cplen = nfft/2;
    sym_size = 2*nfft+cplen;
    td_sig = zeros(1,nTx,sym_size);
    for iTx = 1:nTx
      td_sig(1,iTx,1:cplen) = conj(fft_out(nfft-cplen+1:nfft,iTx)');
      td_sig(1,iTx,(1+cplen):(cplen+nfft)) = conj(fft_out(:,iTx)');
      td_sig(1,iTx,(1+cplen+nfft):(cplen+2*nfft)) = conj(fft_out(:,iTx)');
    end
    return     
end

if (shortgi==1)
    cplen = nfft/8;
else
    cplen = nfft/4;
end
sym_size = nfft+cplen;
td_sig = zeros(nsym,nTx,sym_size);
for isym = 1:nsym
    for iTx = 1:nTx
          td_sig(isym,iTx,1:cplen) = conj(fft_out(nfft-cplen+1:nfft,isym,iTx)');
          td_sig(isym,iTx,1+cplen:sym_size) = conj(fft_out(:,isym,iTx)');
    end
end
  
