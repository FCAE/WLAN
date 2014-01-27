function LLTF_TD = LLTF_Gen
global vecTx;
[pilotPatten,pilotIdx] = CarrierIndxTable('LLTF');
LLTF_FD = pilotPatten;

NtoneField  = fieldTone('LLTF');
Nfft        = vecTx.Nfft;
LLTF_TD     = ifft(fftshift(LLTF_FD),Nfft);
scaleFactor = 1/sqrt(vecTx.Ntx*NtoneField);
LLTF_TD     = LLTF_TD * scaleFactor;
CSDout      = CSD('LLTF',LLTF_TD);

GILen  =  Nfft/2;
for itx = 1:vecTx.Ntx
    LLTF_TD(itx,:) = [CSDout(itx,GILen+1:end) CSDout(itx,:) CSDout(itx,:)];
    % the default window is rectangle
end