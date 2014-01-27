function CSDOutput = CSD(fieldName,input,Nsym);
if nargin <3
    Nsym = 1;
end
global vecTx;
Nfft = vecTx.Nfft;
if strcmp(vecTx.CH_bandWidth,'20MHz')
    Ts = 50;    % sampling interval in unit of ns
elseif strcmp(vecTx.CH_bandWidth,'40MHz')
    Ts = 25;
else
    disp('the wrong setting of BW');
end

switch fieldName
    case {'LSTF','LLTF','LSIG','HTSIG'}
        TcsTable = [0 0 0 0;0 200 0 0;0 100 200 0;0 50 100 150;];
        for ists = 1:vecTx.Ntx      % CSD from time domain
            CSDdly  = fix(TcsTable(vecTx.Nsts,ists)/Ts);
            temp    = [input(CSDdly+1:end) input(1:CSDdly)];
            CSDOutput(ists,:) = temp;
        end
    case {'HTSTF','HTLTF','DATA'}
        TcsTable = -[0 0 0 0;0 400 0 0;0 400 200 0;0 400 200 600;];
        for ists = 1:vecTx.Nsts       % CSD from frequence domain
            CSDdly  = fix(TcsTable(vecTx.Nsts,ists)/Ts);
            RotVec  = exp(-j*2*pi.*[0:Nfft-1]/Nfft * CSDdly);  % [0:63]  need fftshift to [-32:31]
            RotMtx  = repmat(RotVec,1,Nsym);
            if strcmp(fieldName,'DATA')    
                CSDOutput(ists,:) = RotMtx .* input(ists,:);
            else
                CSDOutput(ists,:) = RotMtx .* input;
            end
        end
    otherwise
        disp('the wrong setting of fieldName');
end

return;




