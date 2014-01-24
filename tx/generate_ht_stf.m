%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   function td_htstf = generate_ht_stf(s)
%   generates HT-stf time domain signal
%   Input : s - structure  defining packet
%   Output: td_htstf - time domain samples
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function td_htstf = generate_ht_stf(s)
global PHTLTF;
global tx_n_debug;

LSTF = zeros(64,1);
LSTF(1+bitand(64+(-26:26),63)) = sqrt(1/2)*[0 0 1+j 0 0 0 -1-j 0 0 0 1+j 0 0 0 -1-j 0 0 0 -1-j 0 0 0 1+j 0 0 0 ...
                 0 0 0 0 -1-j 0 0 0 -1-j 0 0 0 1+j 0 0 0 1+j 0 0 0 1+j 0 0 0 1+j 0 0];

if (s.BW==40)
    lstf40mode = 'duplicate';
else     
    lstf40mode = s.BW_20_TO_40;
end

% repeat HT-STF with expand to sts,cdd pre,Qmat,new normalization
    scale = tone_field_scale('HT-STF ',0,(s.MCS ==32),s.use_40_chan)/sqrt(s.NSTS);
    
%HT-STF expand to spatial streams
    if (s.isMM)
        short_full_fft = LSTF*ones(1,s.NSTS);
    else %GF
        short_full_fft = LSTF*PHTLTF(1:s.NSTS,1)';
    end
    tx_n_debug.htstf.symbols = short_full_fft;
    short_full_fft = modulate_or_duplicate (short_full_fft,20,lstf40mode);
    tx_n_debug.htstf.full_band_symbols = short_full_fft;
    short_full_fft =  permute(short_full_fft,[1 3 2]);
    short_full_fft = add_sts_cdd (short_full_fft);
    tx_n_debug.htstf.sts_cdd_symbols = short_full_fft;
    short_full_fft = mul_by_q (short_full_fft,s.Q,s.post_q_cdd);
    tx_n_debug.htstf.after_q_symbols = short_full_fft;
    td_htstf = scale*fd_to_td (short_full_fft,s.out_fft_size);
    tx_n_debug.htstf.fft_samples = td_htstf;
    if (s.isMM)
        td_htstf = add_cp(td_htstf,0);
    else
        td_htstf = add_cp(td_htstf,2);
    end
    tx_n_debug.htstf.after_cp = td_htstf;


