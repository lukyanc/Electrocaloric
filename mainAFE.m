% © Igor Lukyanchuk, lukyanc@ferroix.net, 2020
%
% This intreface script is designated  to calculate the polarization 
% curves and electrocaloric (EC) temperature change for the antiferroelectric material 
% by using the Kittel model, implemented by Pirc [EPL,107,17002 (2014)].
% All the material and output data are collected by the structure M.* 
% that is initialized by the material-parameter function: M=AFE() by default; 
% The name of the material function can be modified according to the
% material.
%
% The following files should be used as the axiliary functions for the
% script and stored at the same directory.
%   AFE.m (by default) initiation of the material (the name can be adopted)
%   PolarFE.m calculation of the polarization
%   EQpircFE.m calculation of the EC effect, solution of the Pirc equation (11)
%
% The outputs of the script are 
% 1. Temperature dependencies of sublattice polarizations Pa=Pa(E,T) and Pb=Pb(E,T), 
%    total polarization P(T)=Pa(T)+Pb(T) and antoferroelectric order parameter  
%    Ps(T)=Pa(T)-Pb(T) for two predefined fields E1 and E2;
% 2.  EC parameters: the initial temperature T1 at E1, the EC induced temperature 
%     T2=T2(T1) at E2  and the EC temperature change DeltaT(T1)=T2-T1
% The outputs are stored in the working space in the structure M.* and can be 
%  (i) exported to  the working screen by typing, e.g. "M" or M.T1
%  (ii) visualized as plots by comment/uncomment of corresponding lines that can be also exported in the png files.
%  (iii) exported to data-files by comment/uncomment of corresponding lines


%%%%%%%%%%%%% calculations %%%%%%%%%%%%%%%%%%%%

close all; clear all; % Clear the previos data in the working space and close all the plots

% Define first the material in the material function (AFE.m by default)  

M=AFE();  % the name of the material function can be adopted to material

M.stra='=== Polarization P(T) at different E';

% Define temperature interval linspace(Tmin, Tmax, Number of points)
% If Tmin=0 take Tmin=0.01;
% Hint: The number of points increases the precision of EC calculations but
% slow-down the calculations. Optimal value is ber=tween100 and 1000
% Format: linspace( Tmin, Tmax, Number of points)

M.T=linspace(0.01,2,100); % The temeprature parameters can be modified 

% Indicate the guessed sublattices polarization range for Pa  and Pb. 
% Pa corresponds to P1 and Pb corresponds to P2 in Pirc [EPL,107,17002 (2014)] . 
%
% Format: M.Paguessed=[Pamin, Pamax], M.Pbguessed=[Pbmin, Pbmax]:

M.Paguessed=[-3, 3]; %The guessed polarization ranges can be modified
M.Pbguessed=[-3, 3]; %The guessed polarization ranges can be modified

% Indicate the fields E1 and E2: E1<E2? (if E1=0, take E1=0.001)
M.E1=0.1; %The electric fields parameters can be modified
M.E2=0.5; %The electric fields parameters can be modified

% calculation of Pa=Pa(E,T) and Pb=Pb(E,T) for E1 and E2;  

  [M.Pa1,M.Pb1]=PolarAFE(M.T,M.E1,M); % This line implies the axuliary function PolarAFE(...) and SHOULD NOT BE MODIFIED
  [M.Pa2,M.Pb2]=PolarAFE(M.T,M.E2,M); % This line implies the axuliary function PolarAFE(...) and SHOULD NOT BE MODIFIED
  M.P1=M.Pa1+M.Pb1;  % This line calculate the total polarization P and SHOULD NOT BE MODIFIED
  M.Ps1=M.Pa1-M.Pb1; % This line calculate the AF order parameter Ps and SHOULD NOT BE MODIFIED
  M.P2=M.Pa2+M.Pb2;  % This line calculate the total polarization P and SHOULD NOT BE MODIFIED
  M.Ps2=M.Pa2-M.Pb2; % This line calculate the AF order parameter Ps and SHOULD NOT BE MODIFIED
  
 % Calculation of T1 and T2 according to Pirc [EPL,107,17002 (2014)] equation (11);
 % The reuslts are presented at the structure M.T1 and M.T2 

 M=EQpircAFE(M);  % This line implies the axuliary function EQpircAFE(M) and SHOULD NOT BE MODIFIED

% Display the parameters at the working screen
% Comment if not necessary

M % this line can be commented/uncommented
 

%%%%%%%%%%%%%%%%%%% plots %%%%%%%%%%%%%%%%%%%%%%%%%%%

 
% plot the polarization curves  P=P(E,T) and Ps=Ps(E,T) for E1 and E2
% where P=Pa+Pb; Ps=Pa-Pb, see   Pirc [EPL,107,17002 (2014)]
% Comment if not necessary

% begin of the plot
figure; 
plot(M.T,abs(M.P1),'.-b',M.T,abs(M.Ps1),'.-r',M.T,abs(M.P2),'*-b',M.T,abs(M.Pa2),'*-r'); 
legend('P(T) at E_1','P_s(T) at E_1','P(T) at E_2','P_s(T) at E_2');
set(gca,  'Fontsize',12,'Fontweight','bold'); 
set(gca,  'Linewidth',1);
xlabel('Temperature, T','Fontsize',12, 'Fontweight','bold');
ylabel('Polarizations, P, P_s','Fontsize',12, 'Fontweight','bold');
title('Polarizations  P=P_a+P_b and P_s=P_a-P_b for different fields','Fontsize',12, 'Fontweight','bold')
grid on;
%print -dpng FigAFEpolar % export to png file FigAFEpolar.png
% end of the plot


% plot electrocaloric temperature change \Delta T as function T1
% Comment if not necessary

% begin of the plot
figure; 
plot(M.T1,M.T2-M.T1,'.-'); 
set(gca,  'Fontsize',12,'Fontweight','bold'); 
set(gca,  'Linewidth',1);
xlabel('Initial temperature, T_1', 'Fontsize',12, 'Fontweight','bold');
ylabel('Temperature change, \Delta T =T_2 - T_1','Fontsize',12, 'Fontweight','bold');
title('Electrocaloric effect','Fontsize',12, 'Fontweight','bold')
grid on; 
% print -dpng FigAFEec % export to png file FigAFEec.png

% end of the plot


%%%%%%%%%%%%%%%%%% data export %%%%%%%%%%%%%%%%%%%%%%%%%%


% Export  polarization curves  P=P(E,T) in file PolarizationAFE.dat as  ascii table
% Order of couloumns: T, Pa1, Pb1, Pa1, Pb2, P1, P2, Ps1, Ps2
% Uncomment if necessary 

% PT=[M.T',M.Pa1',M.Pb1',M.Pa2',M.Pb2',M.P1',M.P2',M.Ps1',M.Ps2']; save 'PolarizationAFE.dat' PT -ascii % This line can be commented/uncommented

% Export initial temperature T1 at E1 and EC induced temperature T2=T2(T1) at E2 
% and EC temperature change DeltaT(T1)=T2-T1   in file T12AFE.dat as  ascii table; 
% Order of couloumns: T1, T2, DeltaT
% attention, the argument, T1, is not necessary equidistant
% Uncomment if necessary 

%T12=[M.T1',M.T2',M.T2'-M.T1']; save 'T12AFE.dat' T12 -ascii % This line can be commented/uncommented




