%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Frequency interleaver function
% frequency_interleaver(org_bits,Ncbpss,Nbpsc,Nrow,Ncol,Nrot,iss)
%
% Input : org_bits bits to interleave (linear array)
%         Ncbpss,Nbpsc,Nrow,Ncol,Nrot mapping parameters
%         iss - input sream (0-(nSS-1))
%
% Output: interleaved bits (linear array)
%
function bits = frequency_interleaver(org_bits,Ncbpss,Nbpsc,Nrow,Ncol,Nrot,iss)

kk = 0:Ncbpss-1;
ii = Nrow*mod(kk,Ncol)+floor(kk/Ncol); % first permutation
s = max(Nbpsc/2,1);
jj = s*floor(ii/s)+mod(ii+Ncbpss-floor(Ncol*ii/Ncbpss),s);% second permutation
if (Nrot>0) % third permutation
    rr = mod((jj-(mod(2*iss,3)+3*floor(iss/3))*Nrot*Nbpsc),Ncbpss);
    jj=rr;
end

bits = reshape(org_bits,Ncbpss,length(org_bits)/Ncbpss)' ; %reshape to symbols
bits(:,1+jj) = bits; % perfrom the permutation
bits = bits';
bits = bits(:); %reshape to vector