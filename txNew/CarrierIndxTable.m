function [pilotPatten,pilotIdx,signalIdx,dataNum] = CarrierIndxTable(fieldName,i_sts)
if nargin<2
    i_sts = 1;
end

global vecTx;
pilotIdx = 0;
signalIdx = 0;
dataNum = 0;
pilotPatten = 0;

if strcmp(vecTx.CH_bandWidth,'20MHz')
    switch (fieldName)
        case {'LSTF','HTSTF'}
            pilotPatten = zeros(1,64);
            HTS = [1 -1 1 -1 -1 1 0 -1 -1 1 1 1 1];
            pilotIdx = [9:4:57];
            pilotPatten(pilotIdx) = HTS*sqrt(1/2)*(1+1i);
            dataNum = 12;
        case 'LLTF'
            pilotPatten = [zeros(1,6) 1,1,-1,-1,1,1,-1,1,-1,1,1,1,1,1,1,-1,-1,1,1,-1,1,-1,1,1,1,1,0,...
            1,-1,-1,1,1,-1,1,-1,1,-1,-1,-1,-1,-1,1,1,-1,-1,1,-1,1,-1,1,1,1,1 zeros(1,5)];
            pilotIdx = [-26:-1 1:26]+33;
            dataNum  = 52;
        case {'LSIG','HTSIG'}
            pilotIdx = [-21 -7 7 21]+33;
            pilotPatten = [1 1 1 -1];
            signalIdx = [7:11 13:25 27:32 34:39 41:53 55:59];
            dataNum = 48;
        case 'HTLTF'
            pilotPatten = [zeros(1,4) 1,1,1,1,-1,-1,1,1,-1,1,-1,1,1,1,1,1,1,-1,-1,1,1,-1,1,-1,1,1,1,1,0,...
            1,-1,-1,1,1,-1,1,-1,1,-1,-1,-1,-1,-1,1,1,-1,-1,1,-1,1,-1,1,1,1,1,-1,-1 zeros(1,3)];
            pilotIdx = [-28:-1 1:28]+33;
            dataNum  = 56;
        case 'DATA'
            pilotIdx = [-21 -7 7 21]+33;
            if vecTx.Nsts == 1
                pilotPatten1 = [1 1 1 -1];
            elseif vecTx.Nsts == 2
                pilotPatten1 = [1 1 -1 -1;1 -1 -1 1];
            elseif vecTx.Nsts == 3
                pilotPatten1 = [1 1 -1 -1;1 -1 1 -1;-1 1 1 -1];
            elseif vecTx.Nsts == 4
                pilotPatten1 = [1 1 1 -1;1 1 -1 1;1 -1 1 1;-1 1 1 1];
            end
            pilotPatten = pilotPatten1(i_sts,:);
            signalIdx = [5:11 13:25 27:32 34:39 41:53 55:61];
            dataNum = 52;
        otherwise disp('the wrong fieldName');
    end
elseif strcmp(vecTx.CH_bandWidth,'40MHz')
else
    disp('the wrong setting of BW');
end

