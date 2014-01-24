%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% function tx_n_highlevel(sim80211nconfig)
%     Input : sim80211nconfig input packet info structure (see documentation)
%     Output:  total_td_sig - time domain signal (nTx x Nsamples)
%              debug_info (optional) - a structure of debug vectors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

function [total_td_sig,debug_info] = tx_n_highlevel(sim80211nconfig)
global tx_n_debug
tx_n_globals

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Read or Prepare bit stream
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (length(sim80211nconfig.BitSource)==0)
    source_bits = create_random_bits(sim80211nconfig.LENGTH*8);
else
    source_bits = read_bits(sim80211nconfig.BitSource);
    sim80211nconfig.LENGTH = length(source_bits)/8;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Check consistency and calculate derived parameters
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sim80211nconfig = mcs_info(sim80211nconfig);
sim80211nconfig = init_bf (sim80211nconfig);
tx_n_debug.full_packet_info = sim80211nconfig;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Save tx bits in file
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 write_bits(source_bits);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Generate the different segments of the transmission
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



tx_data_sig    =      generate_data_tx(sim80211nconfig,source_bits);
td_lstf        =      generate_lstf(sim80211nconfig);
td_lltf        =      generate_lltf(sim80211nconfig);

if (~sim80211nconfig.isGF)
    td_lsig    =      generate_lsig(sim80211nconfig);
end
if ~(sim80211nconfig.islegacy)
    td_htstf   =      generate_ht_stf(sim80211nconfig);
end
% Prepare HT-SIG
if ~(sim80211nconfig.islegacy)
    td_htsig   =      generate_ht_sig(sim80211nconfig);
end
if ~(sim80211nconfig.islegacy)
    [htlfs_sig_cp,htlf1_sig_cp]    =   generate_ht_ltfs(sim80211nconfig);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Merge data and preamble segments
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (sim80211nconfig.islegacy)
    total_td_sig = merge_segments(sim80211nconfig.win,td_lstf,td_lltf,td_lsig,tx_data_sig);
else
    if (sim80211nconfig.isMM)
        total_td_sig = merge_segments(sim80211nconfig.win,td_lstf,td_lltf,td_lsig,td_htsig,td_htstf,htlfs_sig_cp,tx_data_sig);
    else % GF
        total_td_sig = merge_segments(sim80211nconfig.win,td_htstf,htlf1_sig_cp,td_htsig,htlfs_sig_cp,tx_data_sig);
    end
end

if (nargout>1)
    debug_info = tx_n_debug;
end
