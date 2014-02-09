function NtoneField = fieldTone(fieldName)
global vecTx;
switch fieldName
    case 'LSTF'
        if strcmp(vecTx.CH_bandWidth,'20MHZ')
            NtoneField = 12;
        else
            NtoneField = 24;
        end
    case 'LLTF'
        if strcmp(vecTx.CH_bandWidth,'20MHZ')
            NtoneField = 52;
        else
            NtoneField = 104;
        end
    case 'LSIG'
        if strcmp(vecTx.CH_bandWidth,'20MHZ')
            NtoneField = 52;
        else
            NtoneField = 104;
        end
    case 'HTSTF'
        if strcmp(vecTx.CH_bandWidth,'20MHZ')
            NtoneField = 12;
        else
            NtoneField = 24;
        end
    case 'HTLTF'
        if strcmp(vecTx.CH_bandWidth,'20MHZ')
            NtoneField = 56;
        else
            NtoneField = 114;
        end
    case 'HTSIG'
        if strcmp(vecTx.CH_bandWidth,'20MHZ')
            NtoneField = 52;    % for HT_MF; 56 for HT_GF
        else
            NtoneField = 104;   % for HT_MF; 114 for HT_GF
        end
    case 'DATA'
        if strcmp(vecTx.CH_bandWidth,'20MHZ')
            NtoneField = 56;
        else
            NtoneField = 114;
        end
    case 'HTGFSTF'
        if strcmp(vecTx.CH_bandWidth,'20MHZ')
            NtoneField = 12;
        else
            NtoneField = 24;
        end
    otherwise disp('the wrong fieldName');
end




