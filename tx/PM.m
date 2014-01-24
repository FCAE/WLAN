%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       Written by Micha Anholt, Metalink Broadband
%       Contact   micha_a@metalinkbb.com
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function pmat=PM(z,n)
% generate cyclic permutation matrix of size n x n with shift z
function pmat=PM(z,n)
a=zeros(1,n*n);
if (z>=0)
    a((0:n-1)*n+(0:n-1)+1)=1;
    b=reshape(a,n,n);
    pmat=b(:,1+mod((0:n-1)-z,n));
else
    pmat=reshape(a,n,n);
end
