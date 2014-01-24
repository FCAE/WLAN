%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Written in Metalink Broadband
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function set_pre_defined_configuration()
% set gui parameters to chosen pre-defined configuration

config_num=val_get('pre_defined_configuration')-1;

switch config_num
    case 1
        %#1SS -mixed mode 20
        set_song_parameters
        sim80211nconfig.BitSource='';
        sim80211nconfig.LENGTH = 100;
        sim80211nconfig.MCS      = 4;
        sim80211nconfig.CW           ='HT_CW20';
        sim80211nconfig.CW_OFFSET    ='CH_OFF_40';
        sim80211nconfig.output_rate  = 20;
        sim80211nconfig.FORMAT='HT_MM' ;%GreenField
    case 2
        %#1SS -gf 20
        set_song_parameters
        sim80211nconfig.BitSource='';
        sim80211nconfig.LENGTH = 100;
        sim80211nconfig.MCS      = 4;
        sim80211nconfig.CW           ='HT_CW20';
        sim80211nconfig.CW_OFFSET    ='CH_OFF_40';
        sim80211nconfig.output_rate  = 20;
        sim80211nconfig.FORMAT='HT_GF' ;%GreenField

    case 3
        %#2SS -mixed mode 20
        set_song_parameters
        sim80211nconfig.BitSource='';
        sim80211nconfig.LENGTH = 100;
        sim80211nconfig.MCS      = 12;
        sim80211nconfig.CW           ='HT_CW20';
        sim80211nconfig.CW_OFFSET    ='CH_OFF_40';
        sim80211nconfig.output_rate  = 20;
        sim80211nconfig.FORMAT='HT_MM' ;%GreenField
        sim80211nconfig.nTx=2;

    case 4
        %#2SS -gf 20
        set_song_parameters
        sim80211nconfig.BitSource='';
        sim80211nconfig.LENGTH = 100;
        sim80211nconfig.MCS      = 12;
        sim80211nconfig.CW           ='HT_CW20';
        sim80211nconfig.CW_OFFSET    ='CH_OFF_40';
        sim80211nconfig.output_rate  = 20;
        sim80211nconfig.FORMAT='HT_GF' ;%GreenField
        sim80211nconfig.nTx=2;

    case 5
        %#1SS -mixed mode 40
        set_song_parameters
        sim80211nconfig.BitSource='';
        sim80211nconfig.LENGTH = 100;
        sim80211nconfig.MCS      = 4;
        sim80211nconfig.CW           ='HT_CW40';
        sim80211nconfig.CW_OFFSET    ='CH_OFF_40';
        sim80211nconfig.output_rate  = 40;
        sim80211nconfig.FORMAT='HT_MM' ;%GreenField


    case 6
        %#1SS -gf 40
        set_song_parameters
        sim80211nconfig.BitSource='';
        sim80211nconfig.LENGTH = 100;
        sim80211nconfig.MCS      = 4;
        sim80211nconfig.CW           ='HT_CW40';
        sim80211nconfig.CW_OFFSET    ='CH_OFF_40';
        sim80211nconfig.output_rate  = 40;
        sim80211nconfig.FORMAT='HT_GF' ;%GreenField

    case 7
        %#2SS -mixed mode 40
        set_song_parameters
        sim80211nconfig.BitSource='';
        sim80211nconfig.LENGTH = 100;
        sim80211nconfig.MCS      = 12;
        sim80211nconfig.CW           ='HT_CW40';
        sim80211nconfig.CW_OFFSET    ='CH_OFF_40';
        sim80211nconfig.output_rate  = 40;
        sim80211nconfig.FORMAT='HT_MM' ;%GreenField
        sim80211nconfig.nTx=2;

    case 8

        %#2SS -gf 40
        set_song_parameters
        sim80211nconfig.BitSource='';
        sim80211nconfig.LENGTH = 100;
        sim80211nconfig.MCS      = 12;
        sim80211nconfig.CW           ='HT_CW40';
        sim80211nconfig.CW_OFFSET    ='CH_OFF_40';
        sim80211nconfig.output_rate  = 40;
        sim80211nconfig.FORMAT='HT_GF' ;%GreenField
        sim80211nconfig.nTx=2;

    case 9
        % #1SS -mixed mode duplicate
        set_song_parameters
        sim80211nconfig.BitSource='';
        sim80211nconfig.LENGTH = 100;
        sim80211nconfig.MCS      = 32;
        sim80211nconfig.CW           ='HT_CW40';
        sim80211nconfig.CW_OFFSET    ='CH_OFF_40';
        sim80211nconfig.output_rate  = 40;
        sim80211nconfig.FORMAT='HT_MM' ;%GreenField

    case 10
        %#1SS - 2STS stbc=1
        set_song_parameters
        sim80211nconfig.BitSource='';
        sim80211nconfig.LENGTH = 100;
        sim80211nconfig.MCS      = 4;
        sim80211nconfig.CW           ='HT_CW40';
        sim80211nconfig.CW_OFFSET    ='CH_OFF_40';
        sim80211nconfig.output_rate  = 40;
        sim80211nconfig.FORMAT='HT_MM' ;%GreenField
        sim80211nconfig.STBC     = 1;
        sim80211nconfig.nTx=2;

    case 11
        %#1SS - USB
        set_song_parameters
        sim80211nconfig.BitSource='';
        sim80211nconfig.LENGTH = 100;
        sim80211nconfig.MCS      = 5;
        sim80211nconfig.CW           ='HT_CW40';
        sim80211nconfig.CW_OFFSET    ='CH_OFF_20U';
        sim80211nconfig.output_rate  = 80;
        sim80211nconfig.FORMAT='HT_MM' ;%GreenField
        sim80211nconfig.STBC     = 0;
        sim80211nconfig.nTx=1;

        case 12
        %#1SS - Legacy Duplicate
        set_song_parameters
        sim80211nconfig.BitSource='';
        sim80211nconfig.LENGTH = 100;
        sim80211nconfig.MCS      = 5;
        sim80211nconfig.CW           ='HT_CW20DN';
        sim80211nconfig.CW_OFFSET    ='CH_OFF_40';
        sim80211nconfig.output_rate  = 80;
        sim80211nconfig.FORMAT='NON_HT' ;%GreenField
        sim80211nconfig.STBC     = 0;
        sim80211nconfig.nTx=1;
        
    case 13
        set_song_parameters
end

if config_num>0
    sim80211nconfig.post_q_cdd = zeros(1,sim80211nconfig.nTx);
    set_gui_params(sim80211nconfig);
end