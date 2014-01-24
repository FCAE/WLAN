%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function mod_sym = modulate_or_duplicate (sym,org_bw,exp_bw_string)
% This function will create 128 fft point as functino of 64 fft input
% according to :
%
% This function also multiplies the upper part by j
%
%
% Input    sym:Nfft(Beforeshift)x nsym x nsts
%          org_bw 20/40
%          exp_bw_string 
%                       'none' - do nothing 
%                       'upper'
%                       'lower'
%                       'duplicate'
%
% Ouput  
%            mod_sym: Nfft x nsym x nsts

function mod_sym = modulate_or_duplicate (sym,org_bw,exp_bw_string)


if (org_bw==40 )
    if (size(sym,1)~=128)
        errordlg('input vector has wrong format');error('Simulation Error');
    end
    mod_sym = sym;
    mod_sym(1+(0:63),:,:)=mod_sym(1+(0:63),:,:)*j;
    return;
end
if (size(sym,1)~=64)
    errordlg('input vector has wrong format');error('Simulation Error');
end
if (strcmp(exp_bw_string,'none') )
    mod_sym = sym;
    return ;
end

mod_sym = zeros(128,size(sym,2),size(sym,3));
if (strcmp(exp_bw_string,'lower') )
    mod_sym(1+(96:96+31),:,:)= sym(1+(0:31),:,:);
    mod_sym(1+(64:64+31),:,:)=sym(1+(32:63),:,:);
end
if (strcmp(exp_bw_string,'upper') )
    mod_sym(1+(32:32+31),:,:)=sym(1+(0:31),:,:);
    mod_sym(1+(0:31),:,:)=sym(1+(32:63),:,:);
end
if (strcmp(exp_bw_string,'duplicate') )
    mod_sym(1+(0:31),:,:)=sym(1+(32:63),:,:) *j;
    mod_sym(1+(32:32+31),:,:)=sym(1+(0:31),:,:) *j;
    mod_sym(1+(64:64+31),:,:)=sym(1+(32:63),:,:);
    mod_sym(1+(96:96+31),:,:)=sym(1+(0:31),:,:);
end
        
