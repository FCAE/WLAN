%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function td_sig = merge_segments(win,varargin)
% merges different signals to a single signal
% If window is empty then they are concatenated.
% If window is not empty the signals are windowed and added with overlap
function td_sig = merge_segments(win,varargin)
len = 0;
% calculate signal as sum of signals length
for ii=1:nargin-1
    len=len+size(varargin{ii},1)*size(varargin{ii},3);
end
nTx = size(varargin{2},2);
if (length(win)==0)
    td_sig = zeros(nTx,len); % maybe + extras
    start = 1;
    for ii=1:nargin-1
        if (~prod(size(varargin{ii})))
            continue;
        end
        sym_size=size(varargin{ii},3);
        nsym=size(varargin{ii},1);
        for jj=1:nsym
           td_sig(:,start:start+sym_size-1)=shiftdim(varargin{ii}(jj,:,:),1);
           start=start+sym_size;
        end
    end
else
    winlen=length(win);
    td_sig = zeros(nTx,len+winlen); % maybe + extras
    start = 1;
    for ii= 1:nargin-1
        if (~prod(size(varargin{ii})))
            continue;
        end
        sym_size=size(varargin{ii},3);
        % find periodicity (cyclic prefix could be different) 64*floor(/64)
        nsym=size(varargin{ii},1);
        for jj=1:nsym
            symbol=zeros(nTx,sym_size);
            symbol(:,:) = varargin{ii}(jj,:,:);
            symbol_expanded = apply_win(win,symbol);
            td_sig(:,start:start+sym_size+winlen-1)=td_sig(:,start:start+sym_size+winlen-1)+symbol_expanded;
            start=start+sym_size;
        end
    end
end
