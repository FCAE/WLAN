%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% add_cdd
% Input: pilot_and_data_symbols fft_size x n_sym x nsts
%        cdd_vec
% Output: 
%       symbols_cdd fft_size x n_sym x nsts
%

function symbols_cdd = add_cdd (pilot_and_data_symbols,cdd_vec)

nsts =     size(pilot_and_data_symbols,3); % or ntx
nsym =     size(pilot_and_data_symbols,2);
fft_size = size(pilot_and_data_symbols,1);
%symbols_cdd = zeros(size(pilot_and_data_symbols));
symbols_cdd = zeros([fft_size nsym nsts]);
for ists = 1:nsts 
    for isym=1:nsym
        t_exp = -cdd_vec(ists)/50; % number of samples for 64 fft
        symbols_cdd(:,isym,ists) = pilot_and_data_symbols(:,isym,ists).*(exp(j*2*pi*t_exp/64*(0:fft_size-1)'));%*ones(1,nsym));
    end
end
          
          