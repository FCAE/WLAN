%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function scale = tone_field_scale(sig_name,islegacy,ismcs32,uses_double_chan)
% returns scale which is 1/sqrt(NTonesFIeld)
% Inputs: sig_name - string containing signal name: 'L-STF  ','L-LTF  ' etc
%         islegacy,ismcs32,uses_double_chan - the other attributes which are
%         needed for scale determinatino
function scale = tone_field_scale(sig_name,islegacy,ismcs32,uses_double_chan)

names =     ['L-STF  ';'L-LTF  ';'L-SIG  ';'HT-SIG ';'HT-STF ';'HT-LTF ';'HT-Data';'HTSIGGF';];
NTonesField=[12 24;    52 104;   52 104;   52 104;    12 24;    56 114;   56 114;   56 114;];
index = strmatch(sig_name,names );
if ((islegacy||ismcs32) && (index==7))
    index = 2;
end
ToneField =  NTonesField(index,1+uses_double_chan);
scale = 1/sqrt(ToneField);
