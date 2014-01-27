function vecTx = ParameterMCS(vecTx);
if strcmp(vecTx.CH_bandWidth,'20MHz')
        vecTx.Nsd           = 52;
        vecTx.Nsp           = 4;
		vecTx.Nfft 			= 64;
elseif strcmp(vecTx.CH_bandWidth,'40MHz');
        vecTx.Nsd           = 108;
        vecTx.Nsp           = 6;
		vecTx.Nfft 			= 128;
end

switch (mod(vecTx.MCS,8))
    case 0
        vecTx.modulation    = 'BPSK';
        vecTx.codeRate      = '1/2';
        vecTx.Nbpsc         = 1;
    case 1
        vecTx.modulation    = 'QPSK';
        vecTx.codeRate      = '1/2';
        vecTx.Nbpsc         = 2;
    case 2
        vecTx.modulation    = 'QPSK';
        vecTx.codeRate      = '3/4';
        vecTx.Nbpsc         = 2;
    case 3
        vecTx.modulation    = '16QAM';
        vecTx.codeRate      = '1/2';
        vecTx.Nbpsc         = 4;
    case 4
        vecTx.modulation    = '16QAM';
        vecTx.codeRate      = '3/4';
        vecTx.Nbpsc         = 4;
    case 5
        vecTx.modulation    = '64QAM';
        vecTx.codeRate      = '2/3';
        vecTx.Nbpsc         = 6;
    case 6
        vecTx.modulation    = '64QAM';
        vecTx.codeRate      = '3/4';
        vecTx.Nbpsc         = 6;
    case 7
        vecTx.modulation    = '64QAM';
        vecTx.codeRate      = '5/6';		
        vecTx.Nbpsc         = 6;
    otherwise disp('there is wrong setting');
end

if (vecTx.MCS>=0 && vecTx.MCS<=7)
        vecTx.Nss           = 1;
        vecTx.Nes           = 1;
elseif (vecTx.MCS>=8 && vecTx.MCS<=15)
        vecTx.Nss           = 2;
        vecTx.Nes           = 1;
elseif (vecTx.MCS>=16 && vecTx.MCS<=23)
        vecTx.Nss           = 3;
        vecTx.Nes           = 1;
elseif (vecTx.MCS>=24 && vecTx.MCS<=31)
        vecTx.Nss           = 4;
        vecTx.Nes           = 1;
elseif (vecTx.MCS==32)
        vecTx.Nss           = 1;
        vecTx.Nes           = 1;
        vecTx.modulation    = 'BPSK';
        vecTx.codeRate      = '1/2';
        vecTx.Nbpsc         = 1;
        vecTx.Nsd           = 48;
        vecTx.Nsp           = 4;
end
    vecTx.Ncbps         = vecTx.Nbpsc * vecTx.Nsd * vecTx.Nss;
    vecTx.Ndbps         = vecTx.Ncbps * str2num(vecTx.codeRate);






