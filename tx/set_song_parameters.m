%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is a default configuration to generate the 802.11a Annex G packet.
% Should generate the exact waveform of Annex G if window is modified

clear sim80211nconfig     % clear configuration

sim80211nconfig.BitSource='';        % or filename
sim80211nconfig.BitSource='song.hex';        % or filename




sim80211nconfig.FORMAT='NON_HT'; %Legacy  % MixedMode %GreenField
sim80211nconfig.L_LENGTH = 0;    % autocalculate spoofed length
sim80211nconfig.LENGTH   = 5;       % bytes could be overriden by file
sim80211nconfig.MCS      = 5;       % for legacy use 0->7 
sim80211nconfig.SHORT_GI  = 0;
sim80211nconfig.STBC     = 0;
sim80211nconfig.NUM_EXTEN_SS =0;
sim80211nconfig.SMOOTHING =1;
sim80211nconfig.NOT_SOUNDING =1;
sim80211nconfig.LDPC_CODING =0;
sim80211nconfig.AGGREGATION =0;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The mapping of CW and CW_OFFSET from the TXVECTOR definition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        CW              CW_OFFSET         comments
%                        -----           ---------         ---------
%   20Mhz                CW20              N/A             HT and Legacy
%   40Mhz                CW40              CH_OFF_40       including  mcs32
%   40Mhz Duplicate      CW20DN            CH_OFF_40       only legacy
%   40Mhz Upper          CW40              CH_OFF_20U
%   40Mhz Lower          CW40              CH_OFF_20L
%



sim80211nconfig.CW        = 'HT_CW20';  %'HT_CW20','HT_CW40','HT_CW20DN'
sim80211nconfig.CW_OFFSET = 'CH_OFF_40';  %'CH_OFF_40','CH_OFF_20U','CH_OFF_20L'

sim80211nconfig.output_rate = 20;


sim80211nconfig.nTx      = 1;

sim80211nconfig.SERVICE.ScramblerStart  = hex2dec('5d');
sim80211nconfig.SERVICE.bits            = zeros(16,1)  ; % may change reserved to 
                                                         % verify ignores
                                                         % reseverd bits

sim80211nconfig.HT_SIG_RESERVED =1; % It is illegal to set to 0 according to spec
                                    % but can be used in testing to verify
                                    % rx ignores this bit
                                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Spatial expansion and Beamforming initializations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sim80211nconfig.post_q_cdd = zeros(1:sim80211nconfig.nTx); % This is not relevant to Legacy
                                    
sim80211nconfig.calib       = 0; % Setting the bit to 1 will for calibration Q

sim80211nconfig.BF_Q_source ='default'; % 'default' 'const+cdd','general'

%sim80211nconfig.FixedQ      =0;         % specify Q for  'const+cdd'
%sim80211nconfig.Q           = zeros(nTx,nSTS,64); % specify Q for 'general'
sim80211nconfig.win          =[]; % window at sample rate.Set to 0.5 to get exact Annex G
                                    
