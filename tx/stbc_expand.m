%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function sym_stbc = stbc_expand(sym,Ndata)
% input: symbol in linear array and Number of data symbols
% output: added new spatial stream in linear array
function sym_stbc = stbc_expand(sym,Ndata)
sym_stbc = reshape(sym,length(sym)/Ndata,Ndata)';  % reshape and conj each line in ofdm sym
sym_stbc = sym_stbc((1+bitxor((1:size(sym_stbc,1))-1,1)),:);% switch line pairs
sym_stbc(1:2:end,:)=-sym_stbc(1:2:end,:);          % sign invert for first lines
sym_stbc = conj(sym_stbc');                        %transpose
sym_stbc = sym_stbc(:);                            %linear again
sym_stbc = conj(sym_stbc');


