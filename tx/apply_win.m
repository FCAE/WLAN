%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% symbol_windowed = apply_win(win,symbol)
% apply window on symbol
% Input : win - window function
%         symbol - nTx x symbol_size samples
% Ouput: windowed symbol  nTx x (symbol_size+2*length(win))
function    symbol_windowed = apply_win(win,symbol)
sym_size = size(symbol,2);
nTx      = size(symbol,1);
period = 64*floor(sym_size/64);
winlen = length(win);
padpre  = floor((winlen-1)/2);
padpost = ceil ((winlen+1)/2);
pad_left_sig = symbol(:,period-padpre+1:period);
pad_right_sig = symbol(:,sym_size+1-period:sym_size+padpost-period);
win_ntx = repmat(win,nTx,1);
symbol_expanded = [pad_left_sig symbol pad_right_sig ];
symbol_windowed = symbol_expanded;
symbol_windowed(:,1:winlen)=symbol_windowed(:,1:winlen).*win_ntx;
symbol_windowed(:,sym_size+1:sym_size+winlen)=symbol_windowed(:,sym_size+1:sym_size+winlen).*fliplr(win_ntx);

