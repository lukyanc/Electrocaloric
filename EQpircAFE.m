function M=EQpircAFE(M)


% Auxiliary function for mainAFE.m, for calculation of electrocaloric effect in antiferroelectric.  
%
% Calculation of T1 and T2 by solving of  Pirc [EPL,107,17002 (2014)] equation (11);
% The material parameters and polarization temperature results should be
% predefined first by the initial parameer initiation and application of the function PolarAFE(...) in the main script.  
% The reuslts are presented at the structure M.T1 and M.T2 
% The decrasing the temperature step in M.T increase the precission of calculation but impact the calculation time.
%
% © Igor Lukyanchuk, lukyanc@ferroix.net, 2020

M.str3='=== Solution of Pirc EC equation' ;

FF2=M.a1*(M.Pa2.^2+M.Pb2.^2)/(2*M.C);
GG2=exp(FF2)./M.T;

FF1=M.a1*(M.Pa1.^2+M.Pb1.^2)/(2*M.C);
GG1=exp(FF1)./M.T;


Gmax1=max(GG1); Gmax2=max(GG2); Gmax=min(Gmax1,Gmax2);
Gmin1=min(GG1); Gmin2=min(GG2); Gmin=max(Gmin1,Gmin2);

G=linspace(Gmin,Gmax,5000);

M.T1=interp1(GG1,M.T,G);
M.T2=interp1(GG2,M.T,G);

end