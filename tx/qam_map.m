%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% maps a single spatial stream
% function symbols = qam_map(bits,bpsc)
% Input : bits - bits to map
%         bpsc - bits per symbol (1,2,4,6)
% Output: Symbols
%
function symbols = qam_map(bits,bpsc)

MAP1     =            [-1 1];
MAP2     = sqrt(1/2) *[-1 1];
MAP4     = sqrt(1/10)*[-3 -1 3 1];
MAP6     = sqrt(1/42)*[-7 -5 -1 -3 7 5 1 3];

if (bpsc==1)
    symbols = MAP1(bits+1);
    return
end
sym_ind = [reshape(bits,(bpsc/2),length(bits)/(bpsc/2))' ]*2.^(bpsc/2-1:-1:0)';
if (bpsc ==2 )
    sym_re = MAP2(1+sym_ind);
end
if (bpsc ==4 )
    sym_re = MAP4(1+sym_ind);
end
if (bpsc ==6 )
    sym_re = MAP6(1+sym_ind);
end
symbols = sym_re(1:2:end)+j*(sym_re(2:2:end));