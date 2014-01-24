%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function pilots =gen_pilots(num_syms,nsts,npilots,ists,z_start)
% returns pilots for a single spacetime stream.
%  num_syms - number of symbols to generate
%  nsts     - number of space time streams
%  npilots  - number of pilots 4/6
%  ists     - index of current space time stream
%  z_start  - 1 legacy, 2 mm, 3 gf
function pilots =gen_pilots(num_syms,nsts,npilots,ists,z_start)

% z = 2 mm
% z = 3 gf

PilotPolarity1 = [1  1 1 -1];
PilotPolarity2 = [1  1 -1 -1;...
                  1 -1 -1 1];
          
PilotPolarity3 = [ 1   1 -1 -1;...
                   1  -1  1 -1;...  
                  -1   1  1 -1];

PilotPolarity4 = [ 1   1   1 -1;...
                   1   1  -1  1;...  
                   1  -1   1  1;...  
                  -1   1   1  1];

PilotPolarity=zeros(4,4,4); % Nsts,ists,npilot
PilotPolarity(1,1,:) = PilotPolarity1;
PilotPolarity(2,1:2,:) = PilotPolarity2;
PilotPolarity(3,1:3,:) = PilotPolarity3;
PilotPolarity(4,1:4,:) = PilotPolarity4;

PilotPolar1_40 = [1  1 1 -1  -1  1];
PilotPolar2_40 = [1  1 -1 -1 -1 -1;...
                  1  1  1 -1  1  1];
          
PilotPolar3_40 = [ 1   1 -1 -1 -1 -1 ;...
                   1   1  1 -1  1  1;...  
                   1  -1  1 -1 -1  1 ];

PilotPolar4_40 = [ 1   1 -1 -1 -1 -1 ;...
                   1   1  1 -1  1  1;...  
                   1  -1  1 -1 -1  1;...  
                  -1   1  1  1 -1  1];

PilotPolarity_40=zeros(4,4,6); % Nsts,ists,npilot
PilotPolarity_40(1,1,:) = PilotPolar1_40;
PilotPolarity_40(2,1:2,:) = PilotPolar2_40;
PilotPolarity_40(3,1:3,:) = PilotPolar3_40;
PilotPolarity_40(4,1:4,:) = PilotPolar4_40;

if (npilots==4)
    PilotTable = squeeze(PilotPolarity(nsts,ists,:));
else
    PilotTable = squeeze(PilotPolarity_40(nsts,ists,:));
end

pilots = PilotTable(1+mod((0:num_syms-1)'*ones(1,npilots)+ones(num_syms,1)*(0:npilots-1),npilots));
if (size(pilots,2)==1)
    pilots=pilots'; % single sym case
end



% need to multiply by global mask


 
%Pilot sequence 1-127 cyclic
pilot_seq =[1 1 1 1 -1 -1 -1 1 -1 -1 -1 -1 1 1 -1 1 -1 -1 1 1 -1 1 1 -1 1 1 1 1 1 1 -1 1 ...
           1 1 -1 1 1 -1 -1 1 1 1 -1 1 -1 -1 -1 1 -1 1 -1 -1 1 -1 -1 1 1 1 1 1 -1 -1 1 1 ...
           -1 -1 1 -1 1 -1 1 1 -1 -1 -1 1 1 -1 -1 -1 -1 1 -1 -1 1 -1 1 1 1 1 -1 1 -1 1 -1 1 ...
           -1 -1 -1 -1 -1 1 -1 1 1 -1 1 -1 1 1 1 -1 -1 1 -1 -1 -1 1 1 1 -1 -1 -1 -1 -1 -1 -1];

   
pilot_seq_bits = pilot_seq(1+mod(z_start+(0:num_syms-1),127));


pilots = pilots.*(pilot_seq_bits'*ones(1,npilots));

pilots=pilots';
pilots = pilots(:);
if (size(pilots,2)==1)
    pilots=pilots';
end