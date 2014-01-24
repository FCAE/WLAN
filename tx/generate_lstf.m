%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function td_lstf = generate_lstf(s)
% generate L-STF
% Input: s - structure defining packet
% Output: td_lstf - time domain samples for L-STF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function td_lstf = generate_lstf(s)
global tx_n_debug;
if (s.BW==40)
    lstf40mode = 'duplicate';
else     
    lstf40mode = s.BW_20_TO_40;
end

scale = tone_field_scale('L-STF  ',s.islegacy,(s.MCS ==32),s.use_40_chan);

LSTF = zeros(64,1);
LSTF(1+bitand(64+(-26:26),63)) = sqrt(1/2)*[0 0 1+j 0 0 0 -1-j 0 0 0 1+j 0 0 0 -1-j 0 0 0 -1-j 0 0 0 1+j 0 0 0 ...
                 0 0 0 0 -1-j 0 0 0 -1-j 0 0 0 1+j 0 0 0 1+j 0 0 0 1+j 0 0 0 1+j 0 0];

%L-STF 
tx_n_debug.lstf.symbols = LSTF;
long_full_fft = modulate_or_duplicate (LSTF,20,lstf40mode);
tx_n_debug.lstf.full_band_symbols = long_full_fft;
%copy for all antennas
long_full_fft=long_full_fft*ones(1,s.nTx)/sqrt(s.nTx);
long_full_fft =  permute(long_full_fft,[1 3 2]);
long_full_fft = add_legacy_cdd (long_full_fft);
tx_n_debug.lstf.after_legacy_cdd_symbols = long_full_fft;
td_lstf = scale*fd_to_td (long_full_fft,s.out_fft_size);
tx_n_debug.lstf.fft_samples = td_lstf;
td_lstf = add_cp(td_lstf,2);
tx_n_debug.lstf.after_cp = td_lstf;
