function [txSymbol txBits] = txGenerate(vecTx); 
% only include the HT_MF frame
global vecTx;
vecTx = ParameterMCS(vecTx);                % configure parameter
[txBB txBits] = txFrameGenerate(vecTx);     % including: interleaving, modulation, STBC, IFFT, etc
[txFE] = txFrondEnd(txBB);                  % including: shape filter, upsample, RF effect(IQ imbalance or DC), etc
[txRF] = txChannel(txFE);                   % including: MIMO, multi-path, noise, doppler,etc
