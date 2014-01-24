%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function td_lsig=generate_lsig(s)
% Input:s - structure defining packet
% Output: td_lsig - time domain signal for L-SIG
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function td_lsig=generate_lsig(s)
global tx_n_debug;
if (s.BW==40)
    lstf40mode = 'duplicate';
else     
    lstf40mode = s.BW_20_TO_40;
end


scale = tone_field_scale('L-SIG  ',s.islegacy,(s.MCS ==32),s.use_40_chan);

lsigbits =[ bitand(floor(s.LSigRateField*(2.^-(0:3))),1)  0 ...
           bitand(floor(s.L_LENGTH*(2.^-(0:11))),1)  ];
parity = bitand(sum(lsigbits),1);
lsigbits = [lsigbits parity 0 0 0 0 0 0];
tx_n_debug.lsig.bits = lsigbits;
lsig_enc_bits  =conv_enc(lsigbits);
tx_n_debug.lsig.coded_bits = lsig_enc_bits;
lsig_intleaved = frequency_interleaver(lsig_enc_bits,48,1,3,16,0,1);
tx_n_debug.lsig.frequency_interleaved_bits = lsig_intleaved;
lsigsym        = qam_map(lsig_intleaved,1);
tx_n_debug.lsig.data_symbols = lsigsym;
Leg_carriers = ([(-26:-22) (-20:-8) (-6:-1) (1:6) (8:20) (22:26) ]);
lsig_pilots = gen_pilots_leg(1,0);%Nsym,skip
tx_n_debug.lsig.pilot_symbols = lsig_pilots;
lsigsym = merge_pilot_and_data(lsigsym,lsig_pilots,20,Leg_carriers,[-21 -7 7 21]);
tx_n_debug.lsig.all_symbols = lsigsym;
lsig_full_fft = modulate_or_duplicate (lsigsym,20,lstf40mode);
tx_n_debug.lsig.full_band_symbols = lsig_full_fft;
lsig_full_fft=lsig_full_fft*ones(1,s.nTx)/sqrt(s.nTx);
lsig_full_fft =  permute(lsig_full_fft,[1 3 2]);
lsig_full_fft = add_legacy_cdd (lsig_full_fft);
tx_n_debug.lsig.legacy_cdd_symbols = lsig_full_fft;
td_lsig = scale*fd_to_td (lsig_full_fft,s.out_fft_size);
tx_n_debug.lsig.fft_sampels = td_lsig;
td_lsig = add_cp(td_lsig,0); 
tx_n_debug.lsig.after_cp_samples = td_lsig;
