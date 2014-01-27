vecTx.format            = 'HT_MF';
vecTx.non_HT_modulation = 'OFDM';
vecTx.L_length          = 4095;
vecTx.L_dataRate        = '6M';
vecTx.L_sigValid        = 1;
vecTx.MCS               = 1;
vecTx.CH_bandWidth      = '20MHz';      % '20MHz' or '40MHz'
vecTx.CH_offset         = 'CH_OFF_20';  % 'CH_OFF_20' 'CH_OFF_40' 'CH_OFF_20U'or 'CH_OFF_20L'
vecTx.length            = 65535;
vecTx.smoothing         = 1;
vecTx.STBC              = 0;
vecTx.Num_exten_SS      = 0;
vecTx.Ntx               = 1;
vecTx.expension_MAT     = 'COMPRESSED_SV';
vecTx.expension_MAT_type= 0;            % 1:expension_MAT is present 0:not present


LSTF.idx = [];



vecTx = ParameterMCS(vecTx);


















