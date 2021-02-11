% this program prints the mesh blocks

close all

% face description
faces = [1 2 3 4; ...
         1 4 8 5; ...
         5 6 2 1; ...
         2 6 7 3; ...
         4 3 7 8; ...
         5 6 7 8];

figure(2)     
for ii = 1:length(block)
      
    verts = block(ii).vertex;      

    g = hgtransform;     
    patch('Vertices',verts,'Faces',faces,'FaceColor',[.75 .75 .75],'Parent',g);
    hold on

end

view(2)
box on
axis vis3d
daspect([1 1 1])