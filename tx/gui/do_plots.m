%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Written in Metalink Broadband
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function do_plots(sig)

%-- get handles
h1=get(gcf);
bb=h1.Children;
AxesHand=[];
for ii=1:length(bb)
    cc=get(bb(ii));
    if strcmp(cc.Type,'axes')
        AxesHand=[AxesHand bb(ii)];
    end
end

%-- plot time domain
set(gcf,'CurrentAxes',AxesHand(3));
cla;
sampling_rate=10*2^val_get('output_rate');
plot( (1:length(sig(1,:)))/sampling_rate , real(sig(1,:)) );grid on
xlabel('Time [microsec]');
ylabel('Real part amplitude');

%-- plot psd
set(gcf,'CurrentAxes',AxesHand(2));
[H F]=psd(sig(1,:),256,sampling_rate);
H=fftshift(H);
F=F-max(F)/2;
plot(F,10*log10(H)),grid
xlabel('Frequency [MHz]');
ylabel('PSD [dB]')

 