classdef hexBLOCK
% this object is related to the definition of the objects used int OpenFOAM 
% to describe the mesh. The mesh is composed by vertex points and this points
% are linked in a counterclockwise direction 
%  
%    P4            P3
%    o-------------o
%    |             |
%    |             |
%    |             |
%    |             |
%    |             |
%    o-------------o 
%    P1            P2
% 
    
    properties
       vertex     = zeros(8,3)
       vertexNAME = zeros(8,1)
    end
    
    
    
    
end