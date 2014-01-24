%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function bits = ldpc_encode(inp,ldpc_params)
% performs ldpc encoding.
% Input: inp - input bits
%        ldpc_params - encoding params structure for packet
% Ouput: encoded bits
function bits = ldpc_encode(inp,ldpc_params)
bits=zeros(ldpc_params.N_avbits,1);
generator_matrix = calculate_generator_matrix(ldpc_params.N_Blk,ldpc_params.code_rate_ind);
in_blk_start_ptr=1; % where the next block starts
out_blk_start_ptr=1; % where the next block starts
for ii=1:ldpc_params.N_cw
    ldpc_bits=zeros(ldpc_params.K_Blk,1);% initialize to 0 
    
    % calculate size of data,parity and repeat
    blk_size = ldpc_params.K_Blk-ldpc_params.shortvec(ii);
    parity_size = ldpc_params.N_Blk-ldpc_params.K_Blk-ldpc_params.puntvec(ii);
    rep_size = ldpc_params.repvec(ii);
    
    % copy systematic part to ldpc encoder input buffer
    ldpc_bits(1:blk_size)=inp(in_blk_start_ptr:in_blk_start_ptr+blk_size-1);
    in_blk_start_ptr=in_blk_start_ptr+blk_size;
    
    % generate parity 
    parity = bitand((generator_matrix* ldpc_bits) , 1);
    
    % combine the two after shortening and pucturing
    ldpc_data_and_parity = [ldpc_bits(1:blk_size);parity(1:parity_size)];
    
    % generate repeat bits by copying (possibly cyclically) data and parity
    rep_bits=ldpc_data_and_parity(1+mod((0:rep_size-1),length(ldpc_data_and_parity)));
    
    % combine entire block
    ldpc_block= [ldpc_data_and_parity;rep_bits];
    blk_out_size = length(ldpc_block);
    
    % copy  to output
    bits(out_blk_start_ptr:out_blk_start_ptr+blk_out_size-1)=ldpc_block; 
    out_blk_start_ptr = out_blk_start_ptr+blk_out_size;
    
end
