function [Pa,Pb]=PolarAFE(TT,E,M)
 
%Auxiliary function for mainAFE.m, for calculation of sulattice polarizations in antiferroelectrics.  
%
% Calculations of the sublattice polarizations Pa(TT) and Pb(T) for AFE 
% for given E are done by the minimization of the Kittel functional F 
% implemented by Pirc in [EPL,107,17002 (2014)].
% (Pa corresponds to P1 and Pb corresponds to P2 in Pirc)
% The material data should be pre-defined by the structure M.*  
%
% © Igor Lukyanchuk, lukyanc@ferroix.net, 2020

 Nmesh=100; n=4;    % the optimized parameters of the mesh size 
 %and number of mesh-scaling itterations impact the precision and
 %calculation time
 
        
 
P=[];  Pa=[]; Pb=[];
    for T=TT
  
        Pleft=M.Paguessed(1); Pright=M.Paguessed(2); 
        Pup=M.Pbguessed(1);   Pdown=M.Pbguessed(2);
        
 %  Pleft=-3; Pright=3; Pup=-3; Pdown=3;
  % Pguessed=[Pleft, Pright; Pdown, Pup];
  % Pg=Pguessed;
 
        for nn=1:n
  Px=linspace(Pleft,Pright,Nmesh); 
  Py=linspace(Pup,Pdown,Nmesh);
  [PPx,PPy]=meshgrid(Px,Py);
       
         
        F=(1/2)*(M.g+M.a1*(T-M.T0))*(PPx.^2+PPy.^2) ...
         + (1/4)*M.b*(PPx.^4+PPy.^4) ...
         + (1/6)*M.c*(PPx.^6+PPy.^6)  ... 
         + M.g*PPx.*PPy - (PPx+PPy)*E;
     
        
        minF = min(F(:));
        [Nymin,Nxmin] = find(F==minF);
        Nymin=Nymin(1);   % Ny
        Nxmin=Nxmin(1);   % Nx
        P1min=PPx(Nymin,Nymin); 
        P2min=PPy(Nxmin,Nxmin);
        
        
        %%%% formation of new down-scaled mesh 
        
      
        
         Ndown=max(Nymin+1,1);
         Nup=min(Nymin-1,Nmesh);
         Nleft=max(Nxmin-1,1);
         Nright=min(Nxmin+1,Nmesh);
%         
%         
         Pleft=Px(Nleft); 
         Pright=Px(Nright); 
         Pdown=Py(Ndown); 
         Pup=Py(Nup);
        end
        
        Pa=[Pa,P1min]; Pb=[Pb,P2min];
    
    end
    
   

    


end