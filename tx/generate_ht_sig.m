%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function td_htsig = generate_ht_sig(s)
%  generates ht-sig samples
%  Input: s - packet structure
%  Output td_htsig - time domain samples for ht-sig
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function td_htsig = generate_ht_sig(s)

global PHTLTF;
global tx_n_debug;

if (s.BW==40)
    lstf40mode = 'duplicate';
else     
    lstf40mode = s.BW_20_TO_40;
end
if (s.isMM)
    scale = tone_field_scale('HT-SIG ',0,(s.MCS ==32),s.use_40_chan);
else %gf
    scale = tone_field_scale('HTSIGGF',0,(s.MCS ==32),s.use_40_chan);
end

htsigbits =[ bitand(floor(s.MCS*(2.^-(0:6))),1)     ...
                ((s.BW==40)||(s.MCS==32))            ...   % mcs is treated as 20 Mhz with duplicate
                bitand(floor(s.LENGTH*(2.^-(0:15))),1)  ... 
                s.SMOOTHING     ...
                s.NOT_SOUNDING&(s.NUM_EXTEN_SS==0) & ~s.calib   ...           % force to 0 if calibration
                s.HT_SIG_RESERVED      ...              
                s.AGGREGATION   ...
                bitand(floor(s.STBC*(2.^-(0:1))),1)  ... 
                s.LDPC_CODING                 ...
                s.SHORT_GI                            ...
                bitand(floor(s.NUM_EXTEN_SS*(2.^-(0:1))),1)  ... 
          ];


   
   crc = ones(1,8);
   for ii=1:34
      c0 = bitand(crc(8)+htsigbits(ii),1);
      c1 = bitand(crc(1)+crc(8)+htsigbits(ii),1);      
      c2 = bitand(crc(2)+crc(8)+htsigbits(ii),1);      
      crc = [c0 c1 c2 crc(3:7)];
   end
   crc=bitxor(crc,1);
htsigbits = [htsigbits crc(8:-1:1) 0 0 0 0 0 0];
tx_n_debug.htsig.bits=htsigbits;
htsig_enc_bits  =conv_enc(htsigbits);
tx_n_debug.htsig.coded_bits=htsig_enc_bits;
htsig_intleaved = frequency_interleaver(htsig_enc_bits,48,1,3,16,0,1);
tx_n_debug.htsig.interleaved_bits=htsig_intleaved;
htsigsym        = j*qam_map(htsig_intleaved,1);
tx_n_debug.htsig.data_symbols=htsigsym;
Leg_carriers = ([(-26:-22) (-20:-8) (-6:-1) (1:6) (8:20) (22:26) ]);
htsig_pilots = gen_pilots_leg(2,1);%Nsym,skip
tx_n_debug.htsig.pilot_symbols=htsig_pilots;
htsigsym = merge_pilot_and_data(htsigsym,htsig_pilots,20,Leg_carriers,[-21 -7 7 21]);
tx_n_debug.htsig.all_symbols=htsigsym;
% expand to spacetimestreams
htsig_full_fft = modulate_or_duplicate (htsigsym,20,lstf40mode);
tx_n_debug.htsig.full_band_symbols=htsig_full_fft;
if (s.isMM)
    htsig_full_ffttmp = zeros([size(htsig_full_fft,1) 2 s.nTx ]);
    for iTx = 1:s.nTx
        htsig_full_ffttmp(:,:,iTx)=htsig_full_fft(:,:)/sqrt(s.nTx);
    end
    htsig_full_fft = htsig_full_ffttmp;
    htsig_full_fft = add_legacy_cdd (htsig_full_fft);
    tx_n_debug.htsig.legacy_cdd_symbols=htsig_full_fft;
else %gf
    htsig_full_ffttmp = zeros([size(htsig_full_fft,1) 2  s.NSTS ]);
    for ists = 1: s.NSTS
        htsig_full_ffttmp(:,:,ists)=htsig_full_fft(:,:)*PHTLTF(ists,1)/sqrt(s.NSTS);
    end
    htsig_full_fft = htsig_full_ffttmp;
    htsig_full_fft = add_sts_cdd (htsig_full_fft);
    tx_n_debug.htsig.sts_cdd_symbols=htsig_full_fft;
    htsig_full_fft = mul_by_q (htsig_full_fft,s.Q,s.post_q_cdd);
    tx_n_debug.htsig.after_q_symbols=htsig_full_fft;
end
td_htsig = scale*fd_to_td (htsig_full_fft,s.out_fft_size);
tx_n_debug.htsig.fft_samples = td_htsig;
td_htsig = add_cp(td_htsig,0);%sig,shortgi
tx_n_debug.htsig.after_cp = td_htsig;
