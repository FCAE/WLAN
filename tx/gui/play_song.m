%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Written in Metalink Broadband
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% run 802.11a song configuration

h1=get(gcf);
bb=h1.Children;
AxesHand=[];
for ii=1:length(bb)
    cc=get(bb(ii));
    if strcmp(cc.Type,'axes')
        AxesHand=[AxesHand bb(ii)];
    end
end

set(gcf,'CurrentAxes',AxesHand(2));
cla
run_song;
set(gcf,'CurrentAxes',AxesHand(1));
psd(total_td_sig)