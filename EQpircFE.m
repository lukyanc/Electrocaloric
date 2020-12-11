function M=EQpircFE(M)

% Auxiliary function for mainFE.m, for calculation of electrocaloric effect in ferroelectric.  
%
% Calculation of T1 and T2 by solving of  Pirc Pirc [JAP,110, 074113 (2011) equation (8);
% The material parameters and polarization temperature results should be
% predefined first by the initial parameer initiation and application of the function PolarFE(...) in the main script.  
% The reuslts are presented at the structure M.T1 and M.T2 
%
% © Igor Lukyanchuk, lukyanc@ferroix.net, 2020

M.str3='=== Solution of Pirc EC equation' ;

FF2=M.a1.*M.P2.^2/(2*M.C);
GG2=exp(FF2)./M.T;

FF1=M.a1.*M.P1.^2/(2*M.C);
GG1=exp(FF1)./M.T;



%figure; plot(TT2,GG2,TT1,GG1); grid on; %xlim([400 600]);

Gmax1=max(GG1); Gmax2=max(GG2); Gmax=min(Gmax1,Gmax2);
Gmin1=min(GG1); Gmin2=min(GG2); Gmin=max(Gmin1,Gmin2);

G=linspace(Gmin,Gmax,5000);

M.T1=interp1(GG1,M.T,G);
M.T2=interp1(GG2,M.T,G);

end