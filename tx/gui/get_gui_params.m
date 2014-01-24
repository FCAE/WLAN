%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Written in Metalink Broadband
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sim80211nconfig=get_gui_params()
% get params from gui

clear sim80211nconfig     % clear configuration

sim80211nconfig.BitSource=str_get('bit_source');
format_vec=str_get('format'); %str2mat('NON_HT','HT_MM ','HT_GF ');
sim80211nconfig.FORMAT= str2mat(format_vec(val_get('format'),:));
sim80211nconfig.L_LENGTH=num_get('l_length');
sim80211nconfig.LENGTH=num_get('length');
sim80211nconfig.MCS=val_get('mcs')-2;
if sim80211nconfig.MCS<0
errordlg('MCS not set')
error('MCS not set');
end
sim80211nconfig.STBC     = val_get('stbc')-1;
sim80211nconfig.NUM_EXTEN_SS = val_get('num_exten_ss')-1;
cw_vec=str_get('cw'); 
sim80211nconfig.CW=str2mat(cw_vec(val_get('cw')));
cw_offset_vec=str_get('cw_offset'); 
sim80211nconfig.CW_OFFSET=str2mat(cw_offset_vec(val_get('cw_offset')));
sim80211nconfig.nTx=val_get('ntx');
sim80211nconfig.output_rate =10*2^val_get('output_rate');
sim80211nconfig.SHORT_GI  = val_get('short_gi')-1;
sim80211nconfig.win = num_get('win');
sim80211nconfig.calib = val_get('calib')-1;
bf_q_source_vec=str_get('bf_q_source'); 
sim80211nconfig.BF_Q_source=str2mat(bf_q_source_vec(val_get('bf_q_source')));
sim80211nconfig.SERVICE.ScramblerStart  = num_get('service_scrabler_start');
sim80211nconfig.SMOOTHING = val_get('smoothing')-1;
sim80211nconfig.NOT_SOUNDING =val_get('sounding')-1;
sim80211nconfig.LDPC_CODING =val_get('ldpc_coding')-1;
sim80211nconfig.AGGREGATION =val_get('aggregation')-1;;
sim80211nconfig.post_q_cdd = eval(str_get('post_q_cdd'));
sim80211nconfig
sim80211nconfig.SERVICE
% not un gui
sim80211nconfig.HT_SIG_RESERVED =1; % It is illegal to set to 0 according to spec
sim80211nconfig.SERVICE.bits= zeros(16,1);
%sim80211nconfig
if (sim80211nconfig.output_rate~=40) && (strcmp(sim80211nconfig.FORMAT,'802.11b')==1)
    sim80211nconfig.output_rate=40;
    val_set('output_rate',2);
    fig=msgbox('11b: output rate changed to 40 Mhz','modal')
    uiwait(fig)
end