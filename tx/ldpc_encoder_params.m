%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function ldpc_params=ldpc_encoder_params(length,code_rate_ind,mstbc,Ncpbs)
% This function generates a structure of ldpc related parameters
% Inputs:
%        length - packet length inbytes 
%        code_rate_ind - 0,1,2,3 representing 1/2,2/3,3/4,5/6 respectively
%        mstbc         - 1,2 representing non stbc and stbc respectively
%        Ncpbs         - total coded bits for OFDM symbol


function ldpc_params=ldpc_encoder_params(length,code_rate_ind,mstbc,Ncpbs)
global num_vec denum_vec;
num=num_vec(1+code_rate_ind);
denum=denum_vec(1+code_rate_ind);
R=num/denum;

N_pld = length*8+16;
N_avbits=Ncpbs*mstbc*ceil(N_pld/Ncpbs/R/mstbc);
if (N_avbits<=648)
    N_cw=1;
    if(N_avbits>=N_pld+912/denum) % 1-R = 1/denum
        N_Blk = 1296;
    else
        N_Blk = 648;
    end
elseif(N_avbits<=1296)
    N_cw=1;
    if(N_avbits>=N_pld+1464/denum) % 1-R = 1/denum
        N_Blk = 1944;
    else
        N_Blk = 1296;
    end
elseif(N_avbits<=1944)
    N_cw=1;
    N_Blk = 1944;
elseif(N_avbits<=2592)
    N_cw=2;
    if(N_avbits>=N_pld+2916/denum) % 1-R = 1/denum
        N_Blk = 1944;
    else
        N_Blk = 1296;
    end
else
    N_Blk = 1944;    
    N_cw=ceil(N_pld/(N_Blk*R));
end
N_shrt = N_cw* N_Blk*R-N_pld;
N_punct = max(0,N_cw* N_Blk-N_avbits-N_shrt);

% Floating point operation have been replaced by integer operations using
% 1-R = 1/denum
% R/(1-R) = num
%
if ((10*N_punct>N_cw* N_Blk/denum) && (10*N_shrt<12*N_punct*num)) ||(10*N_punct>3*N_cw* N_Blk/denum)
    N_avbits=N_avbits+Ncpbs*mstbc;
    N_punct = max(0,N_cw* N_Blk-N_avbits-N_shrt);
end
Nsym = N_avbits/Ncpbs;
Nrep=max(0,N_avbits-N_cw* N_Blk/denum-N_pld);    



shortvec=floor(N_shrt/N_cw)*ones(1,N_cw);;
inx=N_shrt-N_cw*floor(N_shrt/N_cw);
shortvec(1:inx)=shortvec(1:inx)+1;


puntvec=floor(N_punct/N_cw)*ones(1,N_cw);
ind=N_punct-N_cw*floor(N_punct/N_cw);
puntvec(1:ind)=puntvec(1:ind)+1;

repvec=floor(Nrep/N_cw)*ones(1,N_cw);
ind=Nrep-N_cw*floor(Nrep/N_cw);
repvec(1:ind)=repvec(1:ind)+1;

ldpc_params.code_rate_ind = code_rate_ind;
ldpc_params.N_cw=N_cw;
ldpc_params.N_Blk=N_Blk;
ldpc_params.K_Blk=N_Blk*num/denum;   % N_Blk*R
ldpc_params.N_pld=N_pld;
ldpc_params.Nsym=Nsym;
ldpc_params.N_avbits=N_avbits;
ldpc_params.shortvec=shortvec;
ldpc_params.puntvec=puntvec;
ldpc_params.repvec=repvec;
