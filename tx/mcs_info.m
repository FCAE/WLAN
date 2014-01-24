%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function s_out = mcs_info(s_in)
% This functions validates the input structure and calculates derived
% internal parameters. The additinal parameters are appended to the
% structure and returned as the output


function s_out = mcs_info(s_in)

global Legacy_Info   MCS_Info20   MCS_Info40;
global PHTLTF;
global Punct num_vec denum_vec;
global Pilot_Subcarriers_20 Pilot_Subcarriers_40;



s_out = s_in;



s_out.islegacy = strcmp(s_in.FORMAT,'NON_HT');
s_out.isMM     = strcmp(s_in.FORMAT,'HT_MM');
s_out.isGF     = strcmp(s_in.FORMAT,'HT_GF');

if (~s_out.islegacy && ~s_out.isMM && ~s_out.isGF)
     errordlg('Invalid value for FORMAT');error('Simulation Error');
end

% Translate the extern CW and CW_OFFSET parameters from TXVECTOR to
% internal parameters which are 
% BW=20 if there is one band or if subchannels are not independet
%    40 40 Mhz HT operation
% BW_20_TO_40 = 
%         'upper' upper mode
%         'lower' lower mode
%         'duplicate' for 40Mhz duplicate and(!) mcs 32

s_out.BW_20_TO_40='none'; % default
s_out.BW=20;
s_out.in_fft_size = 128;
if (strcmp(s_in.CW,'HT_CW40'))
    if (strcmp(s_in.CW_OFFSET,'CH_OFF_20U'))
        s_out.BW_20_TO_40='upper';
        s_out.use_40_chan = 0;           % for scaling table
    elseif(strcmp(s_in.CW_OFFSET,'CH_OFF_20L'))
         s_out.BW_20_TO_40='lower';
        s_out.use_40_chan = 0;           % for scaling table
    elseif(strcmp(s_in.CW_OFFSET,'CH_OFF_40'))
        s_out.use_40_chan = 1;           % for scaling table
        if (s_in.MCS~=32)
            s_out.BW=40;
        else
            s_out.BW_20_TO_40='duplicate';
        end
    else
        errordlg('Invalid value for CW_OFFSET');error('Simulation Error');
    end
elseif (strcmp(s_in.CW,'HT_CW20DN'))
    s_out.BW_20_TO_40='duplicate';
    s_out.use_40_chan = 1;               % for scaling table
    if(~s_out.islegacy)
        errordlg('Duplicate is defined for Legacy packets only');error('Simulation Error');
    end
elseif(strcmp(s_in.CW,'HT_CW20'))
    if (s_in.MCS==32)
        errordlg('MCS 32 is transmitted with CW = HT_CW40 only');error('Simulation Error');
    end
    s_out.in_fft_size = 64;
    s_out.use_40_chan = 0;               % for scaling table
else
    errordlg('Invalid value for CW');error('Simulation Error');
end

if (s_in.output_rate~=20 && s_in.output_rate~=40 && s_in.output_rate~=80)
    errordlg ('invalid output rate. Pick 20,40,80' );error('Simulation Error');
end
if(~strcmp(s_in.CW,'HT_CW20') && s_in.output_rate==20)
    errordlg ('invalid output rate.Pick 40,80 ' ) ;error('Simulation Error');
end


s_out.out_fft_size =64*(s_in.output_rate/20); % should be 20/40/80

% check for sanity

if (s_out.islegacy)
    if (s_in.SHORT_GI)
        errordlg('Short Gi is not allowed in Legacy Mode');error('Simulation Error');
    end
    if (s_in.LENGTH>4095)
        errordlg('Length is too large for legacy packet');error('Simulation Error');
    end
    if (s_in.MCS>7)
        errordlg('Mcs too large for legacy packet');error('Simulation Error');
    end
    if (s_in.LENGTH<=0)
        errordlg('Length is incompatible with legacy packet' );error('Simulation Error');
    end
end

if (s_out.islegacy)
    s_out.CodeRateInd = Legacy_Info(s_in.MCS+1,2);
    s_out.Nss=1;
    s_out.NSTS=1;
    s_out.NBPSC         =Legacy_Info(s_in.MCS+1,3); 
    s_out.Constellations=Legacy_Info(s_in.MCS+1,3); 
    s_out.Ndata=48;
    s_out.Npilots=4;
    s_out.NCBPS=s_out.Ndata * s_out.NBPSC;
    s_out.NDBPS=s_out.Ndata * s_out.NBPSC* num_vec(1+s_out.CodeRateInd)/denum_vec(1+s_out.CodeRateInd);
    s_out.NE=1;
    s_out.NCOL = 16;
    s_out.NROW = s_out.NCBPS/16;
    s_out.NROT = 0;
    s_out.Nsym = ceil((16+8*s_in.LENGTH+6)/s_out.NDBPS);
    s_out.NDataBits = s_out.Nsym*s_out.NDBPS;
    s_out.Pilot_Subcarriers=Pilot_Subcarriers_20;
    s_out.Data_Subcarriers=([(-26:-22) (-20:-8) (-6:-1) (1:6) (8:20) (22:26) ]);
    s_out.L_LENGTH = s_in.LENGTH;
    s_out.LSigRateField = Legacy_Info(s_in.MCS+1,4);
    s_out.L_DATARATE    = s_out.NDBPS/4; % 4 is symbol duration in usec Rate is in Mbps
else  % not in legacy packet
    if (s_in.LENGTH<0 || s_in.LENGTH>=2^16)
        errordlg('Length is incompatible with 802.11n packet' );error('Simulation Error');
    end
    
    if (s_out.BW == 20 )
        s_out.Pilot_Subcarriers=Pilot_Subcarriers_20;    
        s_out.Npilots = 4;
        if (s_in.MCS==32)
            s_out.Data_Subcarriers=([(-26:-22) (-20:-8) (-6:-1) (1:6) (8:20) (22:26) ]);
            mcs_line=[32 0 1 1 0 0 0];
        else
            mcs_line = MCS_Info20(find(MCS_Info20(:,1)==s_in.MCS),:);
            s_out.Data_Subcarriers=([(-28:-22) (-20:-8) (-6:-1) (1:6) (8:20) (22:28)]);
        end
    else
        mcs_line = MCS_Info40(find(MCS_Info40(:,1)==s_in.MCS),:);
        s_out.Pilot_Subcarriers=Pilot_Subcarriers_40;
        s_out.Data_Subcarriers=([(-58:-54) (-52:-26) (-24:-12) (-10:-2) (2:10) (12:24) (26:52) (54:58)]);
        s_out.Npilots = 6;
    end
    s_out.Ndata =length(s_out.Data_Subcarriers);
    s_out.CodeRateInd = mcs_line(2);
    s_out.Nss=mcs_line(3);
    s_out.NSTS=s_out.Nss+s_in.STBC; % not all combinations are allowed here
    if ((s_out.NSTS==1) && s_out.isGF && s_in.SHORT_GI)
        errordlg('Short GI cannot be set for GF 1 space time stream' );error('Simulation Error');
    end
    s_out.Constellations=mcs_line(4:4+s_out.Nss -1);
    s_out.NBPSC=sum(s_out.Constellations);
    s_out.NCBPS=s_out.NBPSC*s_out.Ndata;
    s_out.NDBPS=s_out.NCBPS*num_vec(1+s_out.CodeRateInd)/denum_vec(1+s_out.CodeRateInd);
    if (s_in.SHORT_GI)
        Rate = s_out.NDBPS/3.6;
    else
        Rate = s_out.NDBPS/4;
    end
    
    if (s_out.MCS == 32)
        s_out.NCOL = 16;
        s_out.NROW = s_out.NCBPS/16;
        s_out.NROT = 0;
    elseif (s_out.BW == 20)
        s_out.NCOL = 13;
        s_out.NROW = 4*s_out.Constellations;
        s_out.NROT = 11;
    else
        s_out.NCOL = 18;
        s_out.NROW = 6*s_out.Constellations;
        s_out.NROT = 29;
    end
    if (s_out.Nss==1)
        s_out.NROT = 0;
    end

    mstbs = 1+(s_out.STBC>0);
    if (s_in.LDPC_CODING)
        s_out.ldpc_params = ldpc_encoder_params(s_in.LENGTH,s_out.CodeRateInd,mstbs,s_out.NCBPS);
        s_out.Nsym=s_out.ldpc_params.Nsym;
        s_out.NDataBits=s_out.ldpc_params.N_pld;
    else
        % start of BCC specific
        s_out.NE=1+(Rate>300);  % here condition may change to 1+(RateLongCP>300)
        s_out.Nsym = mstbs*ceil((16+8*s_in.LENGTH+6*s_out.NE)/(s_out.NDBPS*mstbs));
        %end of bcc specific
        s_out.NDataBits = s_out.Nsym*s_out.NDBPS;
    end
    s_out.NDataLTF = s_out.NSTS+(s_out.NSTS==3);
    s_out.NExteneionLTF = s_out.NUM_EXTEN_SS+(s_out.NUM_EXTEN_SS==3);
    s_out.NTotalLTF = s_out.NDataLTF+s_out.NExteneionLTF;
    if (s_out.NTotalLTF>5)
        errordlg('Sum of data and extension LTFs more than 5');error('Simulation Error');
    end
    % calculate Lsig length if not specified externally
    % if spedified externally will take external value
    if ((s_in.L_LENGTH==0) && s_out.isMM)
        if (s_in.SHORT_GI)
            symbolTime=9/10;
        else
            symbolTime=1;
        end
        s_out.L_LENGTH = 3*(ceil(s_out.Nsym*symbolTime)+s_out.NTotalLTF+3)-3;
    end
    s_out.LSigRateField   = Legacy_Info(0+1,4);
    s_out.L_DATARATE      = 6;
end




s_out.PtPattern = Punct{s_out.CodeRateInd +1};


stbc_1_msc_list = ([(0:23) (33:39)  41 43 46 48 50 ]);
stbc_2_msc_list = [(8:15) (33:38)];
if (s_in.STBC)
    if (s_in.STBC==1)
        if length(find(stbc_1_msc_list==s_in.MCS))==0
            errordlg('mcs is not compatible with stbc');error('Simulation Error');
        end
    elseif (s_in.STBC==2)
        if length(find(stbc_2_msc_list==s_in.MCS))==0
            errordlg('mcs is not compatible with stbc');error('Simulation Error');
        end
    end
end



