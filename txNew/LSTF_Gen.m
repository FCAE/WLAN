function LSTF_TD = LSTF_Gen;
global vecTx;
[pilotPatten,pilotIdx] = CarrierIndxTable('LSTF');

LSTF_FD     = pilotPatten;
NtoneField  = fieldTone('LSTF');
Nfft        = vecTx.Nfft;
LSTF_TD     = ifft(fftshift(LSTF_FD),Nfft);
scaleFactor = 1/sqrt(vecTx.Ntx*NtoneField);
LSTF_TD     = LSTF_TD * scaleFactor;
CSDout      = CSD('LSTF',LSTF_TD);

GILen  =  Nfft/4;
for itx = 1:vecTx.Ntx
    temp = CSDout(itx,1:GILen);
    LSTF_TD(itx,:) =repmat(temp,1,10); 
    % the default window is rectangle
end

