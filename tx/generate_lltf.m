%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  function td_lltf = generate_lltf(s)
%  Generate L_LTF 
%  Input: s - structure defining packet
%  Output: td_lltf - time domain signal for L-LTF
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function td_lltf = generate_lltf(s)
global tx_n_debug;

% generate L-LTF or HT-LTF1
if (s.BW==40)
    lstf40mode = 'duplicate';
else     
    lstf40mode = s.BW_20_TO_40;
end

scale = tone_field_scale('L-LTF  ',s.islegacy,(s.MCS ==32),s.use_40_chan);


LLTF = zeros(64,1);
LLTF(1+bitand(64+(-26:26),63)) = [1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1   ...
        0 1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1];

tx_n_debug.lltf.symbols = LLTF;
long_full_fft = modulate_or_duplicate (LLTF,20,lstf40mode);
tx_n_debug.lltf.full_band_symbols = long_full_fft;
long_full_fft=long_full_fft*ones(1,s.nTx)/sqrt(s.nTx);
long_full_fft =  permute(long_full_fft,[1 3 2]);
long_full_fft = add_legacy_cdd (long_full_fft);
tx_n_debug.lltf.after_legacy_cdd_symbols = long_full_fft;
td_lltf = scale*fd_to_td (long_full_fft,s.out_fft_size);
tx_n_debug.lltf.fft_samples = td_lltf;
td_lltf = add_cp(td_lltf,2); 
tx_n_debug.lltf.after_cp_samples = td_lltf;

