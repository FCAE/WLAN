%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function generator=calculate_generator_matrix(blk_size,code_rate_enum)
%  calculates generator matrix
function generator=calculate_generator_matrix(blk_size,code_rate_enum)
% Get code table from the spec
[tab,z]=getcodetable(blk_size,code_rate_enum);

n=blk_size;
n_min_k=size(tab,1)*z;
k=n-n_min_k;

% translate table to parity check matrix
parity_check_table=zeros(size(tab)*z);
for ii=1:size(tab,1)
    for jj=1:size(tab,2)
        parity_check_table((ii-1)*z+1:ii*z,(jj-1)*z+1:jj*z)=PM(tab(ii,jj),z);
    end
end

% translate to standard form 
% inverse over reals must contain integer entries so we can use matlab
% inverse functions
generator = mod (inv(parity_check_table(:,(k+1:n)))*parity_check_table(:,(1:k)),2);
generator = round(generator); % make sure enries are integer and not almost integers
