function [PPDU txBits] = txFrameGenerate(vecTx); 
global vecTx
switch vecTx.format
    case {'NON_HT'}
    case {'HT_MF'}
        PPDU = HT_MF_Gen; 
    case {'HT_GF'}
    otherwise disp('the worng frame format');
end