%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function symbols = merge_pilot_and_data(data_sym,pilot_sym,BW,data_c,pilot_c)
% merges pilot and data to fft symbol
% BW = 20/40
% data_c,pilot_c - carrier indices for data and pilot
function symbols = merge_pilot_and_data(data_sym,pilot_sym,BW,data_c,pilot_c)
nSTS = size(data_sym,1);
if (nSTS>4)
    errordlg('data size is wrong');error('Simulation Error');
end
Nsym = size(data_sym,2)/length(data_c);
ndata = size(data_c,2);
npilot = size(pilot_c,2);

if BW==20
    fft_size = 64;
else
    fft_size = 128;
end
symbols =   zeros(fft_size,Nsym,nSTS);

for iSTS = 1:nSTS
    sts_sym    =  data_sym(iSTS,:);
    p_sym      =  pilot_sym(iSTS,:);
    sts_sym    =  reshape(sts_sym,length(data_c),Nsym);
    p_sym      =  reshape(p_sym,length(pilot_c),Nsym);
    symbols (1+ bitand(data_c+fft_size,fft_size-1),:,iSTS) = sts_sym(1:ndata,:);
    symbols (1+ bitand(pilot_c+fft_size,fft_size-1),:,iSTS) = p_sym(1:npilot,:);
end




