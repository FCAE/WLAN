%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%   function td_data_sig = generate_data_tx(s,source_bits)         %%%%
%%%%%   generate data samples of packet                                %%%%
%%%%%   Input:   s - input structure defining packet                   %%%%
%%%%%            source_bits - data bits                               %%%%
%%%%%   Output:  time domain signal                                    %%%%
%%%%%                                                                  %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function td_data_sig = generate_data_tx(s,source_bits)
global tx_n_debug;
% add service and pad bits
pad_and_tail = s.NDataBits-length(source_bits)-16;
source_bits = [s.SERVICE.bits;source_bits;zeros(pad_and_tail,1)];

tx_n_debug.data.source_bits=source_bits;
% scrambling

scr_bits = bitxor(source_bits,scrambler_seq(s.SERVICE.ScramblerStart,length(source_bits))');
tx_n_debug.data.scrambled_bits=scr_bits;

if (s.LDPC_CODING)
    after_enc = ldpc_encode(scr_bits,s.ldpc_params);
else    %% BCC start

    %separate to encoders

    bits_per_enc_before_tail = (s.LENGTH*8+16)/s.NE;
    for iES = 1:s.NE
        % Get Stream i
        stream = scr_bits(iES:s.NE:end);
        % insert tail bits and separate to streams
        stream(bits_per_enc_before_tail+1:bits_per_enc_before_tail+6)=0;
        tx_n_debug.data.stream_bits{iES}=stream;
        % conv encode
        conv_enc_bits=conv_enc(stream);
        tx_n_debug.data.conv_enc_bits{iES}=stream;
        puct_bits = puncture_bits(conv_enc_bits,s.PtPattern);
        tx_n_debug.data.punct_bits{iES}=stream;
        if (iES==1)
            after_enc = puct_bits;
        else
            after_enc = merge_encoders(after_enc,puct_bits,s.Constellations);
        end
    end

    %% BCC end
end
tx_n_debug.data.encoded_bits=after_enc;

% here for loop on streams
for iSS = 1: s.Nss
    %streamparse
    bits_per_ss_i = stream_parse(after_enc,s.Constellations,iSS);
    tx_n_debug.data.stream_parse{iSS}=bits_per_ss_i;
    NCBPSS = s.NCBPS*s.Constellations(iSS)/sum(s.Constellations);
    Nbpsc  = s.Constellations(iSS);
    if (s.LDPC_CODING) % skip freq interleaver for LDPC 
        input_to_mapper = bits_per_ss_i;
    else
        %freq interleave
        bits_intleaved = frequency_interleaver(bits_per_ss_i,NCBPSS,Nbpsc,s.NROW(iSS),s.NCOL,s.NROT,iSS-1);
        tx_n_debug.data.interleaved_bits{iSS}=bits_intleaved;
        input_to_mapper = bits_intleaved;
    end
    %mapper
    symbols_i = qam_map(input_to_mapper,Nbpsc);
    if (iSS ==1)
        symbols = symbols_i;
    else
        symbols = [symbols ; symbols_i];
    end        
    %stbc
    if (iSS<=s.STBC)
        symbols = [symbols ; stbc_expand(symbols_i,s.Nsym)];
    end        
end
tx_n_debug.data.data_symbols=symbols;

% here symbosl is NSTS X (NSYM*Ndatacarriers)

% generate pilots

for ists = 1: s.NSTS
    if (s.islegacy)
        pilot = gen_pilots_leg(s.Nsym,1);
    else
        if (s.isMM)
    		if (s.MCS==32)
		      pilot = gen_pilots_leg(s.Nsym,3);
    		else
	          pilot = gen_pilots(s.Nsym, s.NSTS,s.Npilots,ists,3);
    		end
        else  % GF mode
    		if (s.MCS==32)
		       pilot = gen_pilots_leg(s.Nsym,2);
    		else
	           pilot = gen_pilots(s.Nsym, s.NSTS,s.Npilots,ists,2);
    		end
        end
    end
    if (ists==1)
        allpilots = pilot;
    else
        allpilots =  [allpilots;pilot];
    end
end
tx_n_debug.data.pilot_symbols=allpilots;
% merge pilot and data to fft_sym
pilot_and_data_symbols = merge_pilot_and_data(symbols,allpilots,s.BW ...
                       ,s.Data_Subcarriers,s.Pilot_Subcarriers);

% here output is carrier x symbol x ists

% make duplicate or modulate or mul by j
pilot_and_data_symbols = modulate_or_duplicate (pilot_and_data_symbols,s.BW,s.BW_20_TO_40);
                   
tx_n_debug.data.full_band_symbols=pilot_and_data_symbols;

if (~s.islegacy)
    pilot_and_data_symbols = add_sts_cdd (pilot_and_data_symbols);
    tx_n_debug.data.after_sts_cdd_symbols=pilot_and_data_symbols;
end

% multiply by Qk 

pilot_and_data_symbols = mul_by_q (pilot_and_data_symbols,s.Q,s.post_q_cdd);
tx_n_debug.data.after_spatial_expansion_symbols = pilot_and_data_symbols;

% Apply Tx chain cdd for legacy transmission
if (s.islegacy)
    pilot_and_data_symbols = add_legacy_cdd (pilot_and_data_symbols);
    tx_n_debug.data.after_legacy_cdd_symbols = pilot_and_data_symbols;
end

% ifft
scale = tone_field_scale('HT-Data',s.islegacy,(s.MCS ==32),s.use_40_chan)/sqrt(s.NSTS);
td_sig = scale*fd_to_td (pilot_and_data_symbols,s.out_fft_size);
tx_n_debug.data.after_fft_samples = td_sig;

% add cp

td_sig_cp = add_cp(td_sig,s.SHORT_GI);
tx_n_debug.data.after_cp_samples = td_sig_cp;

% window

td_data_sig = td_sig_cp;



