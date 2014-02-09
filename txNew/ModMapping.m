function [symMap] = ModMapping(dataIn,Ndsc,NSyms,BPSC,ModScheme);
symShape = reshape(dataIn,BPSC,Ndsc,NSyms);

switch ModScheme
    case {'BPSK'}
        Kmod = 1;
        symShape = 2*symShape -1 ;
        if NSyms > 1
            symMap = Kmod * squeeze(symShape).';
        else
            symMap = Kmod * squeeze(symShape);
        end
    case {'QPSK'}
        Kmod = 1/sqrt(2);
        symShape = 2*symShape -1 ;
        if NSyms > 1
            symMap = Kmod * squeeze(symShape(1,:,:) + 1i*symShape(2,:,:)).';
        else
            symMap = Kmod * squeeze(symShape(1,:,:) + 1i*symShape(2,:,:)).';
        end
    case {'16QAM'}
        Kmod = 1/sqrt(10);
        table = [-3 -1 3 1];
        DataReal = squeeze(2*symShape(1,:,:) + symShape(2,:,:))+1;
        DataImag = squeeze(2*symShape(3,:,:) + symShape(4,:,:))+1;
        ConstReal = table(DataReal);
        ConstImag = table(DataImag);
        if NSyms > 1
            symMap = Kmod * (ConstReal + 1i * ConstImag).';
        else
            symMap = Kmod * (ConstReal + 1i * ConstImag);
        end
    case {'64QAM'}
        Kmod = 1/sqrt(42);
        table = [-7 -5 -1 -3 7 5 1 3]; % gray encoding
        DataReal = squeeze(4*symShape(1,:,:) + 2*symShape(2,:,:) + symShape(3,:,:))+1;
        DataImag = squeeze(4*symShape(4,:,:) + 2*symShape(5,:,:) + symShape(6,:,:))+1;
        ConstReal = table(DataReal);
        ConstImag = table(DataImag);
        if NSyms > 1
            symMap = Kmod * (ConstReal + 1i * ConstImag).';
        else
            symMap = Kmod * (ConstReal + 1i * ConstImag);
        end
    otherwise disp('the wrong setting of ModScheme');
end