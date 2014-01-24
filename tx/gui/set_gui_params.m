%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Written in Metalink Broadband
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function set_gui_params(sim80211nconfig)

str_set('bit_source',sim80211nconfig.BitSource);


num_set('l_length',sim80211nconfig.L_LENGTH);
num_set('length',sim80211nconfig.LENGTH);

val_set('mcs',sim80211nconfig.MCS+2);
val_set('stbc',sim80211nconfig.STBC+1);
val_set('num_exten_ss',sim80211nconfig.NUM_EXTEN_SS+1);
val_set('ntx',sim80211nconfig.nTx);
val_set('output_rate',round(log2(sim80211nconfig.output_rate/10)));
val_set('short_gi',sim80211nconfig.SHORT_GI +1);
num_set('win',sim80211nconfig.win);
val_set('calib',sim80211nconfig.calib+1);

cw_vec=str_get('cw');
cw_ind=strmatch(sim80211nconfig.CW,cw_vec,'exact');
val_set('cw',cw_ind);

cw_offset_vec=str_get('cw_offset'); 
cw_offset_ind=strmatch(sim80211nconfig.CW_OFFSET,cw_offset_vec,'exact');
val_set('cw_offset',cw_offset_ind);

num_set('service_scrabler_start',sim80211nconfig.SERVICE.ScramblerStart);
val_set('smoothing',sim80211nconfig.SMOOTHING+1);
val_set('sounding',sim80211nconfig.NOT_SOUNDING +1);
val_set('ldpc_coding',sim80211nconfig.LDPC_CODING+1);
val_set('aggregation',sim80211nconfig.AGGREGATION +1);;
str_set('post_q_cdd',['[' num2str(sim80211nconfig.post_q_cdd) ']']);

format_vec=str_get('format'); 
format_ind=strmatch(sim80211nconfig.FORMAT,format_vec,'exact');
val_set('format',format_ind);

bf_q_source_vec=str_get('bf_q_source'); 
bf_q_source_ind=strmatch(sim80211nconfig.BF_Q_source,bf_q_source_vec,'exact');
val_set('bf_q_source',bf_q_source_ind);
