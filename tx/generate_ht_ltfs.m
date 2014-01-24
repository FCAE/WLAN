%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      function [htlfs_sig_cp,htlf1_sig_cp ]= generate_ht_ltfs(s)
%      generates the HTLTfs for the preamble
%      Input:  s - packet structure
%      Output:   htlfs_sig_cp - HTLTFs after HT-sig
%                htlf1_sig_cp - HTLTF before HT-sig for gf mode
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [htlfs_sig_cp,htlf1_sig_cp ]= generate_ht_ltfs(s)

global PHTLTF;
global tx_n_debug;

% generate HTLTFs
    LLTF = [1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1   ...
        0 1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1];
    HTLTF20 = zeros(64,1);
    HTLTF20(1+bitand(64+(-28:28),63)) = [1 1  LLTF  -1 -1 ];

    % [-58:58]
    HTLTF40 = zeros(128,1);
    HTLTF40(1+bitand(128+(-58:58),127)) = [1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1   1   ...
   	       1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1  -1 -1 -1 1 0  ...
           0 0 -1 1 1 -1  1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1  ...
        	1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1    ];


    htlf1_sig_cp = zeros(0,s.nTx);

    
    BW = s.BW;
    BW_20_TO_40 = s.BW_20_TO_40;
    if (s.MCS==32)
        BW=40;
        BW_20_TO_40='none';
    end
    
    scale = tone_field_scale('HT-LTF ',0,(s.MCS ==32),s.use_40_chan)/sqrt(s.NSTS);
    htltf_data = zeros([64*BW/20 s.NDataLTF  s.NSTS]);
    for iLTF = 1:s.NDataLTF
        if (BW==40)
            htltf = HTLTF40*PHTLTF(1:s.NSTS,iLTF)';
        else    
            htltf = HTLTF20*PHTLTF(1:s.NSTS,iLTF)';    
        end
        htltf_data(:,iLTF,:) = htltf;
    end
    tx_n_debug.htltf.symbols = htltf_data;
    htltf_data = modulate_or_duplicate (htltf_data,BW,BW_20_TO_40);
    tx_n_debug.htltf.full_band_symbols = htltf_data;
    htltf_data = add_sts_cdd (htltf_data);
    tx_n_debug.htltf.after_sts_cdd_symbols = htltf_data;
    htltf_data = mul_by_q (htltf_data,s.Q,s.post_q_cdd);
    tx_n_debug.htltf.after_q_symbols = htltf_data;
    htlfs_sig = scale*fd_to_td (htltf_data,s.out_fft_size);
    tx_n_debug.htltf.fft_samples = htlfs_sig;
    if (s.isMM)
        htlfs_sig_cp = add_cp(htlfs_sig,0);
    else
        htlf1_sig_cp = add_cp(htlfs_sig(:,1,:),2);
        if (s.NSTS>1)
            htlfs_sig_cp = add_cp(htlfs_sig(:,2:end,:),0);
        else
            htlfs_sig_cp = zeros(s.nTx,0);
        end
    end
    tx_n_debug.htltf.after_cp_samples = htlfs_sig_cp;
    
% generate ExtraLTFs

    if (s.NExteneionLTF)
        scale = tone_field_scale('HT-LTF ',0,(s.MCS ==32),s.use_40_chan)/sqrt(s.NUM_EXTEN_SS);
        htltf_data = zeros([64*BW/20 s.NExteneionLTF s.NUM_EXTEN_SS]);
        for iLTF = 1:s.NExteneionLTF
            if (BW==40)
                htltf = HTLTF40*PHTLTF(1:s.NUM_EXTEN_SS,iLTF)';
            else
                htltf = HTLTF20*PHTLTF(1:s.NUM_EXTEN_SS,iLTF)';    
            end
             htltf_data(:,iLTF,:) = htltf;
        end
        tx_n_debug.extraltf.symbols=htltf_data;
        htltf_data = modulate_or_duplicate (htltf_data,BW,s.BW_20_TO_40);
        tx_n_debug.extraltf.full_band_symbols=htltf_data;
        htltf_data = add_sts_cdd (htltf_data);
        tx_n_debug.extraltf.sts_cdd_symbols=htltf_data;
        htltf_data = mul_by_q (htltf_data,s.Q(1:s.nTx,s.NSTS+1:s.NSTS+s.NUM_EXTEN_SS,:),s.post_q_cdd);
        tx_n_debug.extraltf.after_q_symbols=htltf_data;
        htlfs_sig = scale*fd_to_td(htltf_data,s.out_fft_size);
        tx_n_debug.extraltf.fft_samples=htlfs_sig;
        htlfsextra_sig_cp = add_cp(htlfs_sig,0);
        tx_n_debug.extraltf.after_cp=htlfsextra_sig_cp;
        if (s.isMM || (s.NSTS>1) )
            htlfs_sig_cp = cat(1,htlfs_sig_cp,htlfsextra_sig_cp);
        else
            htlfs_sig_cp=htlfsextra_sig_cp
        end
    end
