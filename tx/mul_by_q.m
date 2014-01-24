%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function sym_tx_ant =  mul_by_q (sts_symbols,q_mat,post_q_cdd)
% multiply by  Q matrix and adds cdd
% The cdd could be added on top of Q instead of defining it separately but 
% for spatial expansion it is more clear to separate const matrix and cdd
% Input 
%           sts_symbols :fft_size x nsym x nsts
%           q_mat   :    nTx x nSTS x nFFT
%           post_q_cdd: cdd to apply after the multiplication
% Output
%           sym_tx_ant fft_size x nsym x nTx
%

function sym_tx_ant = mul_by_q (sts_symbols,q_mat,post_q_cdd)


nsts =     size(sts_symbols,3);
nsym =     size(sts_symbols,2);
fft_size = size(sts_symbols,1);
nTx = size(q_mat,1);
q_bin = zeros(nTx,nsts);
sym_tx_ant = zeros([fft_size nsym nTx]);
for nfft = (1:fft_size)
    for isym = 1:nsym
        q_bin = q_mat(1:nTx,1:nsts,nfft); % extract Q for specific bin
        sym_tx_ant(nfft,isym,:) = q_bin*squeeze(sts_symbols(nfft,isym,:));
    end
end
sym_tx_ant=add_cdd(sym_tx_ant,post_q_cdd);

