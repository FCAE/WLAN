%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function s_out = init_bf(s_in)
%  Verifies BF configuration and expands Q matrix
%  Input  - packet info structure
%  Output - modified structure
function s_out = init_bf(s_in)
global PHTLTF;

s_out = s_in;

global T_ITX_CS; %table n65
if (s_out.islegacy)
  s_out.post_q_cdd=zeros(1,s_out.nTx);
  % in this case Q will be used to duplicate the streams to antennas
  % cdd that will take effect will be legacy cdd in a separate module.
end
if (s_out.calib)

  % initialize calibration, override external Q or cdd
  if (s_out.NUM_EXTEN_SS ~= s_out.nTx-s_out.NSTS) 
      errordlg ('number of tx antennas should match total number of probed streams');error('Simulation Error');
  end
  Q=PHTLTF(1:s_out.nTx,1:s_out.NSTS+s_out.NUM_EXTEN_SS);
  s_out.post_q_cdd=T_ITX_CS(s_out.nTx,:);
  s_out.Q = reshape(repmat(Q,1,s_in.in_fft_size),size(Q,1),size(Q,2),s_in.in_fft_size);
elseif (strcmp(s_out.BF_Q_source,'default'))
    if (s_out.nTx<s_out.NSTS)
       errordlg('Not enough Tx antennas to support rate');error('Simulation Error');
   end
   if (s_out.NUM_EXTEN_SS>0)
       errordlg('cannot use extendion LTF with direct conversion');error('Simulation Error');
    end
    if (length(s_out.post_q_cdd)<s_out.nTx)
       errordlg('not enough cdd values');error('Simulation Error');
    end
    if (s_out.nTx==s_out.NSTS)
        Q = eye(s_out.NSTS);
    else
        if (s_out.NSTS==1)
            Q = 1/sqrt(s_out.nTx)*ones(s_out.nTx,1);
        else
            if (s_out.NSTS==2 && s_out.nTx==3)
                Q = sqrt(2/3)*([ 1 0 ; 0 1 ; 1 0]);
            end
            if (s_out.NSTS==2 && s_out.nTx==4)
                Q = sqrt(2/4)*([1 0 ; 0 1; 1 0 ; 0 1]);
            end
            if (s_out.NSTS==3 && s_out.nTx==4)
                Q =sqrt(3/4)*([1 0 0 ; 0 1 0 ; 0 0 1; 1 0 0 ;]);
            end
        end
    end
    s_out.Q = reshape(repmat(Q,1,s_in.in_fft_size),size(Q,1),size(Q,2),s_in.in_fft_size);
elseif (strcmp(s_out.BF_Q_source,'const+cdd'))
    % verify Q exists and sizes are correct
    if (size(s_out.FixedQ,1)~=s_out.nTx)
        errordlg('BF matrix should have nTx number of rows');error('Simulation Error');
    end
    if (size(s_out.FixedQ,2)~=(s_out.NSTS+s_out.NUM_EXTEN_SS))
        errordlg('BF matrix should have nSTS+NextLTF number of columns');error('Simulation Error');
    end
    if (length(s_out.post_q_cdd)<s_out.nTx)
       errordlg('not enough cdd values');error('Simulation Error');
    end
    s_out.Q = reshape(repmat(FixedQ,1,s_in.in_fft_size),size(FixedQ,1),size(FixedQ,2),s_in.in_fft_size);

elseif (strcmp(s_out.BF_Q_source,'general'))
    if (size(s_out.Q,3)~=s_out.in_fft_size)
        errordlg('Should supply 64 or 128 BF matrices accroding to mode');error('Simulation Error');
    end
    if (size(s_out.Q,1)~=s_out.nTx)
        errordlg('BF matrix should have nTx number of rows');error('Simulation Error');
    end
    if (size(s_out.Q,2)~=(s_out.NSTS+s_out.NUM_EXTEN_SS))
        errordlg('BF matrix should have nSTS+NextLTF number of columns');error('Simulation Error');
    end
else
    errordlg('invalid BF_Q_source value');error('Simulation Error');
end



