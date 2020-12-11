
function M=AFE()


% Function intiating the the material properties of antiferroelectric
% material for calculation of the electrocaloric effect by script mainAFE.m
% the results are output as the MATRLAB structure M.
% The coefficient of the Kittel model are named and selected to be the same as in 
% Pirc article [EPL,107,17002 (2014)] 
% It is recommended to create the different functions for different
% materials with appropriate name modification. 
%
% © Igor Lukyanchuk, lukyanc@ferroix.net, 2020


M.str1='=== AFE material parameters';

M.T0=1;
M.g=0.5;
M.a1=1;
M.b=1/3; 
M.c=1/3; 
M.g=0.5; 

M.C=5;

end

