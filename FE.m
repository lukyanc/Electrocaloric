function M=FE()

% Function intiating the the material properties of ferroelectric
% material for calculation of the electrocaloric effect by script mainFE.m
% the results are output as the MATRLAB structure M.
% The coefficient of the Ginzburg-Landau model are named and selected to be the same as in 
% Pirc article [JAP,110, 074113 (2011) 
% It is recommended to create the different functions for different
% materials with appropriate name modification. 
%
% © Igor Lukyanchuk, lukyanc@ferroix.net, 2020


M.str1='=== FE material parameters';

M.T0=1; 
M.a1=1; 
M.b=-1/3; 
M.c=1/3; 


M.C=15;


end
