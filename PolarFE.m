function P=PolarFE(TT,E,M)

%Auxiliary function for mainFE.m, for calculation of polarization in ferroelectric.  
%
% Calculations of the polarization P=P(TT)  for given E are done by the minimization 
% of the Ginzburg-Landau functional F  implemented by Pirc in Pirc [JAP,110, 074113 (2011).
% The material data should be pre-defined by the structure M.*  
%
% © Igor Lukyanchuk, lukyanc@ferroix.net, 2020

 Nmesh=1000; 

 Pmin=M.Pguessed(1);
 Pmax=M.Pguessed(2);

 PP=linspace(Pmin,Pmax,Nmesh);
 P=[]; 
 
P=[]; 
    for T=TT       
   F=(1/2)*M.a1*(T-M.T0)*PP.^2+(1/4)*M.b*PP.^4 +(1/6)*M.c*PP.^6-E*PP;
        [Fmin,Nmin]=min(F);
        Pmin=PP(Nmin);     
        P=[P,Pmin]; 
    end



end