function LSIG = LSIG_Gen;
global vecTx;

Nfft = vecTx.Nfft;
switch vecTx.L_dataRate
    case 6
        RateBits = [1 1 0 1];
    case 9
        RateBits = [1 1 1 1];
    case 12
        RateBits = [0 1 0 1];
    case 18
        RateBits = [0 1 1 1];
    case 24
        RateBits = [1 0 0 1];
    case 36
        RateBits = [1 0 1 1];
    case 48
        RateBits = [0 0 0 1];
    case 54
        RateBits = [0 0 1 1];
    otherwise disp('wrong serring for TXrate for LSIG');
end

LengthBits = bitget(vecTx.L_length,[1:12]); %-----[LSB .... MSB]
ParityBits = rem(sum(RateBits) + sum(LengthBits),2);

TailBits = zeros(1,6);
LSIGBits = [RateBits 0 LengthBits ParityBits TailBits];
SignalFieldCoded = ConvEncoder(LSIGBits);

%------------ interleaving -------------
%     0     3     6     9    12    15    18    21    24    27    30    33    36    39    42    45
%     1     4     7    10    13    16    19    22    25    28    31    34    37    40    43    46
%     2     5     8    11    14    17    20    23    26    29    32    35    38    41    44    47
Len = length(SignalFieldCoded);
for k = 0:Len-1
    i(k+1) = (Len/16)*mod(k,16) + floor(k/16);  
end
sigInterleav(i+1) =  SignalFieldCoded;

symMap = ModMapping(sigInterleav,48,1,1,'BPSK');

SLG_FD = zeros(1,Nfft);
[pilotPatten,pilotIdx,signalIdx] = CarrierIndxTable('LSIG');
SLG_FD(pilotIdx)    = pilotPatten;      % for 20MHz
SLG_FD(signalIdx)   = symMap;

NtoneField  = fieldTone('LSIG');
LSIG_TD     = ifft(fftshift(SLG_FD),Nfft);
scaleFactor = 1/sqrt(vecTx.Ntx*NtoneField);
LSIG_TD     = LSIG_TD * scaleFactor;
CSDout      = CSD('LSIG',LSIG_TD);

GILen  =  Nfft/4;
for itx = 1:vecTx.Ntx
    LSIG(itx,:) = [CSDout(itx,end -GILen+1:end) CSDout(itx,:)];
    % the default window is rectangle
end



















