% © Igor Lukyanchuk, lukyanc@ferroix.net, 2020
%
% This intreface script is designated  to calculate the polarization 
% curves and electrocaloric (EC) temperature change for the ferroelectric material 
% by using the Ginzburg-Landau functional, implemented by Pirc [JAP,110, 074113 (2011)].
% All the material and output data are collected by the structure M.* 
% that is initialized by the material-parameter function: M=AFE() by default; 
% The name of the material function can be modified according to the
% material.
%
% The following files should be used as the axiliary functions for the
% script and stored at the same directory.
%   FE.m; (by defauls) initiation of the material (the name can be adopted)
%   PolarFE.m calculation of the polarization
%   EQpircFE.m calculation of the EC effect, solution of the Pirc equation (8)
%
% The outputs of the script are 
% 1. Temperature dependencie of of the  polarization P(T)
%     for two predefined fields E1 and E2;
% 2.  EC parameters: the initial temperature T1 at E1, the EC induced temperature 
%     T2=T2(T1) at E2  and the EC temperature change DeltaT(T1)=T2-T1
% The outputs are stored in the working space in the structure M.* and can be 
%  (i) exported to  the working screen by typing, e.g. "M" or "M.T1"
%  (ii) visualized as plots by comment/uncomment of corresponding lines that can be also exported in the png files.
%  (iii) exported to data-files by comment/uncomment of corresponding lines

%%%%%%%%%%%%% calculations %%%%%%%%%%%%%%%%%%%%


close all; clear all; % Clear the previos data in the working space and close all the plots

% Define first the material in the material function (AFE.m by default)

M=FE();

M.stra='=== Polarization P(T) at different E';

% Define temperature interval linspace(Tmin, Tmax, Number of points)
% If Tmin=0 take Tmin=0.01;
% Hint: The number of points increases the precision of EC calculations but
% slow-down the calculations. Optimal value is ber=tween100 and 1000
% Format: linspace( Tmin, Tmax, Number of points)

M.T=linspace(0.01,2,100); % The temeprature parameters can be modified

% Indicate the guessed sublattices polarization range for P. 
%
% Format: M.Pguessed=[Pamin, Pamax]

M.Pguessed=[0, 2]; %The guessed polarization ranges can be modified
% Indicate the fields E1 and E2: E1<E2? (if E1=0, take E1=0.001
M.E1=0.001;    %The electric fields parameters can be modified   
M.E2=0.02;     %The electric fields parameters can be modified

% calculation of P=P(E,T)  for E1 and E2;

M.P1=PolarFE(M.T,M.E1,M); % This line implies the axuliary function PolarFE(...) and SHOULD NOT BE MODIFIED
M.P2=PolarFE(M.T,M.E2,M); % This line implies the axuliary function PolarAFE(...) and SHOULD NOT BE MODIFIED

% Calculation of T1 and T2 according to Pirc [JAP,110, 074113 (2011)] equation (8);
 % The reuslts are presented at the structure M.T1 and M.T2 

M=EQpircFE(M); % This line implies the axuliary function EQpircAFE(M) and SHOULD NOT BE MODIFIED

% Display the parameters at the working screen
% Comment if not necessary

M % this lines can be commented/uncommented
 

%%%%%%%%%%%%%%%%%%% plots %%%%%%%%%%%%%%%%%%%%%%%%%%%

 
% plot the polarization curves  P=P(E,T) for E1 and E2
% Comment if not necessary

% begin of the plot
figure; 
plot(M.T,M.P1,'.-b',M.T,M.P2,'*-b'); 
legend('P(T) at E_1','P(T) at E_2');
set(gca,  'Fontsize',12,'Fontweight','bold'); 
set(gca,  'Linewidth',1);
xlabel('Temperature, T','Fontsize',12, 'Fontweight','bold');
ylabel('Polarizations, P ','Fontsize',12, 'Fontweight','bold');
title('Polarizations  at different fields','Fontsize',12, 'Fontweight','bold')
grid on;
%print -dpng FigFEpolar % export to png file FigFEpolar.png
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
% print -dpng FigFEec % export to png file FigFEec.png

% end of the plot

%%%%%%%%%%%%%%%%%% data export %%%%%%%%%%%%%%%%%%%%%%%%%%


% Export  polarization curves  P=P(E,T) in file PolarizationFE.dat as  ascii table
% Order of couloumns: T, P1, P2
% Uncomment if necessary 

% PT=[M.T',M.P1',M.P2']; save 'PolarizationFE.dat' PT -ascii % This line can be commented/uncommented

% Export initial temperature T1 at E1 and EC induced temperature T2=T2(T1) at E2 
% and EC temperature change DeltaT(T1)=T2-T1   in file T12FE.dat as  ascii table; 
% Order of couloumns: T1, T2, DeltaT
% attention, the argument, T1, is not necessary equidistant
% Uncomment if necessary 

%T12=[M.T1',M.T2',M.T2'-M.T1']; save 'T12FE.dat' T12 -ascii % This line can be commented/uncommented


