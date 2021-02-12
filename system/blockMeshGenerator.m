clear 
close all
clc

% importing airfoil data
airfoil = ...
[ 1.000000 -0.000000
  0.975752  0.005092
  0.905240  0.018910
  0.795047  0.037760
  0.655659  0.057071
  0.500587  0.072303
  0.344680  0.079180
  0.203313  0.072945
  0.091996  0.054325
  0.022051  0.028152
  0.000000  0.000000
  0.026892 -0.023408
  0.098987 -0.037507
  0.208902 -0.042343
  0.346303 -0.039923
  0.499413 -0.033414
  0.653358 -0.024269
  0.792738 -0.014999
  0.903777 -0.007191
  0.975305 -0.001896
  1.000000  0.000000];
          
% allocating object array
block = hexBLOCK.empty(length(airfoil)+4,0);

% setting up end mesh points
L = 3;
h = 3;

% LOWER REAR part
P4 = [airfoil(end,:),0];
P1 = [P4(1),-h,0];
P2 = P1 + [L,0,0];
P3 = [P2(1),0,0];
P5 = P1 + [0,0,1];
P6 = P2 + [0,0,1];
P7 = P3 + [0,0,1];
P8 = P4 + [0,0,1];

% 1st block description
block(1).vertex     = [P1;P2;P3;P4;P5;P6;P7;P8];
block(1).vertexNAME = 0:7;

figure(1)
hold on
axis equal
grid on 
grid minor
plot(P1(1),P1(2),'og','LineWidth',3)
plot(P2(1),P2(2),'og','LineWidth',3)
plot(P3(1),P3(2),'og','LineWidth',3)
plot(P4(1),P4(2),'og','LineWidth',3)

% UPPER REAR part
P1 = [airfoil(end,:),0]; % ==> P4 for the 1st block
P2 = P1 + [L,0,0];       % ==> P3 fot the 1st block
P3 = [P2(1),h,0];
P4 = [P1(1),h,0];        
P5 = P1 + [0,0,1];       % ==> P8 for the 1st block
P6 = P2 + [0,0,1];       % ==> P7 for the 1st block
P7 = P3 + [0,0,1];
P8 = P4 + [0,0,1];

% 2nd block description
block(2).vertex     = [P1;P2;P3;P4;P5;P6;P7;P8];
block(2).vertexNAME = [3, 2, 8, 9, 7, 6, 10,11]; 

figure(1)
plot(P1(1),P1(2),'ob','LineWidth',3)
plot(P2(1),P2(2),'ob','LineWidth',3)
plot(P3(1),P3(2),'ob','LineWidth',3)
plot(P4(1),P4(2),'ob','LineWidth',3)

% last pointNAME
last = 11;

% UPPER surface discretization 
% the direction is [0,1]
for i=2:(length(airfoil)-1)/2+1
    
    P1 = [airfoil(i,:),0];   
    P2 = [airfoil(i-1,:),0]; % ==> P1 of the previous block
    P3 = [P2(1),h,0];        % ==> P4 of the previous block
    P4 = [P1(1),h,0];
    P5 = P1 + [0,0,1];       
    P6 = P2 + [0,0,1];       % ==> P5 of the previous block   
    P7 = P3 + [0,0,1];       % ==> P8 of the previous block    
    P8 = P4 + [0,0,1];
    
    block(i+1).vertex     = [P1;P2;P3;P4;P5;P6;P7;P8];
    block(i+1).vertexNAME = [last+1,                 ...
                             block(i).vertexNAME(1), ...
                             block(i).vertexNAME(4), ...
                             last+2,                 ...
                             last+3,                 ...
                             block(i).vertexNAME(5), ...
                             block(i).vertexNAME(8), ...
                             last+4                  ];
    
    figure(1)
    plot(P1(1),P1(2),'or','LineWidth',3)
    plot(P2(1),P2(2),'or','LineWidth',3)
    plot(P3(1),P3(2),'or','LineWidth',3)
    plot(P4(1),P4(2),'or','LineWidth',3)
    
    % updating last pointNAME
    last = last + 4;
    
end

% UPPER FRONT part
P2 = [airfoil((length(airfoil)-1)/2+1,:),0];
P3 = [P2(1),h,0];
P4 = P3 + [-L,0,0];
P1 = P2 + [-L,0,0];
P5 = P1 + [0,0,1];
P6 = P2 + [0,0,1];
P7 = P3 + [0,0,1];
P8 = P4 + [0,0,1];

i = (length(airfoil)-1)/2+2;
block(i+1).vertex     = [P1;P2;P3;P4;P5;P6;P7;P8];
block(i+1).vertexNAME = [last+1,                 ...
                         block(i).vertexNAME(1), ...
                         block(i).vertexNAME(4), ...
                         last+2,                 ...
                         last+3,                 ...
                         block(i).vertexNAME(5), ...
                         block(i).vertexNAME(8), ...
                         last+4                  ];

% updating last pointNAME
last = last + 4;

figure(1)
plot(P1(1),P1(2),'og','LineWidth',3)
plot(P2(1),P2(2),'og','LineWidth',3)
plot(P3(1),P3(2),'og','LineWidth',3)
plot(P4(1),P4(2),'og','LineWidth',3)

% LOWER FRONT part
P3 = [airfoil((length(airfoil)-1)/2+1,:),0];
P2 = [P3(1),-h,0];
P4 = P3 + [-L,0,0];
P1 = [P4(1),-h,0];
P5 = P1 + [0,0,1];
P6 = P2 + [0,0,1];
P7 = P3 + [0,0,1];
P8 = P4 + [0,0,1];

i = (length(airfoil)-1)/2+3;
block(i+1).vertex     = [P1;P2;P3;P4;P5;P6;P7;P8];
block(i+1).vertexNAME = [last + 1,               ...
                         last + 2,               ...
                         block(i).vertexNAME(2), ...
                         block(i).vertexNAME(1), ...
                         last + 3,               ...
                         last + 4,               ...
                         block(i).vertexNAME(6), ...
                         block(i).vertexNAME(5)  ];

figure(1)
plot(P1(1),P1(2),'ob','LineWidth',3)
plot(P2(1),P2(2),'ob','LineWidth',3)
plot(P3(1),P3(2),'ob','LineWidth',3)
plot(P4(1),P4(2),'ob','LineWidth',3)

% updating last pointNAME
last = last + 4;

% LOWER surface discretization
% the direction is [0,-1]
for i=(length(airfoil)-1)/2+1:length(airfoil)-1
 
    P3 = [airfoil(i+1,:),0]; 
    P4 = [airfoil(i,:),  0]; % ==> P3 of the previous block 
    P2 = [P3(1),-h,0];       
    P1 = [P4(1),-h,0];       % ==> P2 of the previous block 
    P5 = P1 + [0,0,1];       % ==> P6 of the previous block   
    P6 = P2 + [0,0,1];
    P7 = P3 + [0,0,1];
    P8 = P4 + [0,0,1];       % ==> P7 of the previous block
    
    block(i+4).vertex     = [P1;P2;P3;P4;P5;P6;P7;P8];
    block(i+4).vertexNAME = [block(i+3).vertexNAME(2), ...
                             last + 1,                 ...
                             last + 2,                 ...
                             block(i+3).vertexNAME(3), ...
                             block(i+3).vertexNAME(6), ...
                             last + 3,                 ...
                             last + 4,                 ...
                             block(i+3).vertexNAME(7)  ];
                         
     % updating last pointNAME
     last = last + 4;
                         
    % block(i+4).vertexNAME = block(i+3).vertexNAME(end)+1:block(i+3).vertexNAME(end)+8;

    figure(1)
    plot(P1(1),P1(2),'oc','LineWidth',3)
    plot(P2(1),P2(2),'oc','LineWidth',3)
    plot(P3(1),P3(2),'oc','LineWidth',3)
    plot(P4(1),P4(2),'oc','LineWidth',3)
    
end

% adjusting last block vertexNAME
block(end).vertexNAME(2) = 0;
block(end).vertexNAME(3) = 3;
block(end).vertexNAME(6) = 4;
block(end).vertexNAME(7) = 7;

% writing blockMeshDict file
FILE = fopen('blockMeshDict','w');

% declaration file
fprintf(FILE,'FoamFile \n{ \n\tversion 2.0; \n\tformat ascii; \n\tclass dictionary; \n\tobject blockMeshDict; \n} \n\nscale 1;');

% vertices declaration 
fprintf(FILE,'\n\nvertices \n( \n');

% printing 1st block 
i = 1;
fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(1,1),block(i).vertex(1,2),block(i).vertex(1,3));
fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(2,1),block(i).vertex(2,2),block(i).vertex(2,3));
fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(3,1),block(i).vertex(3,2),block(i).vertex(3,3));
fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(4,1),block(i).vertex(4,2),block(i).vertex(4,3));
fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(5,1),block(i).vertex(5,2),block(i).vertex(5,3));
fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(6,1),block(i).vertex(6,2),block(i).vertex(6,3));
fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(7,1),block(i).vertex(7,2),block(i).vertex(7,3));
fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(8,1),block(i).vertex(8,2),block(i).vertex(8,3));

% printing 2nd block
i = 2; 
fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(3,1),block(i).vertex(3,2),block(i).vertex(3,3));
fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(4,1),block(i).vertex(4,2),block(i).vertex(4,3));
fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(7,1),block(i).vertex(7,2),block(i).vertex(7,3));
fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(8,1),block(i).vertex(8,2),block(i).vertex(8,3));

% printing UPPER aifoil part
for i = 3:(length(airfoil)-1)/2+3
    fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(1,1),block(i).vertex(1,2),block(i).vertex(1,3));
    fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(4,1),block(i).vertex(4,2),block(i).vertex(4,3));
    fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(5,1),block(i).vertex(5,2),block(i).vertex(5,3));
    fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(8,1),block(i).vertex(8,2),block(i).vertex(8,3));
end

% printing left-down block coords
i = (length(airfoil)-1)/2+4;
fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(1,1),block(i).vertex(1,2),block(i).vertex(1,3));
fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(2,1),block(i).vertex(2,2),block(i).vertex(2,3));
fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(5,1),block(i).vertex(5,2),block(i).vertex(5,3));
fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(6,1),block(i).vertex(6,2),block(i).vertex(6,3));

% printing LOWER airfoil part
for i = (length(airfoil)-1)/2+5:length(airfoil)+2
    fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(2,1),block(i).vertex(2,2),block(i).vertex(2,3));
    fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(3,1),block(i).vertex(3,2),block(i).vertex(3,3));
    fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(6,1),block(i).vertex(6,2),block(i).vertex(6,3));
    fprintf(FILE,'\t(%f %f %f)\n',block(i).vertex(7,1),block(i).vertex(7,2),block(i).vertex(7,3));
end

fprintf(FILE,');\n\n');

% block declaration 
nx      = 5;
ny      = 35;
nxblock = 100;
nyblock = ny;
nz      = 1;
Gx      = 1;
Gy      = 1;
Gz      = 1;

fprintf(FILE,'blocks \n( \n');

for i=1:length(block) 
    if(i == 1 || i == 2 || i == ((length(airfoil)-1)/2+3) || i == ((length(airfoil)-1)/2+4) )
        fprintf(FILE,'\t// %d hexBLOCK \n', i);
        fprintf(FILE,'\thex (%d %d %d %d %d %d %d %d) (%d %d %d) simpleGrading (%f %f %f) \n', block(i).vertexNAME(1), block(i).vertexNAME(2), block(i).vertexNAME(3), block(i).vertexNAME(4), block(i).vertexNAME(5), block(i).vertexNAME(6), block(i).vertexNAME(7), block(i).vertexNAME(8), nxblock, nyblock, nz, Gx, Gy, Gz);
    else
        fprintf(FILE,'\t// %d hexBLOCK \n', i);
        fprintf(FILE,'\thex (%d %d %d %d %d %d %d %d) (%d %d %d) simpleGrading (%f %f %f) \n', block(i).vertexNAME(1), block(i).vertexNAME(2), block(i).vertexNAME(3), block(i).vertexNAME(4), block(i).vertexNAME(5), block(i).vertexNAME(6), block(i).vertexNAME(7), block(i).vertexNAME(8), nx, ny, nz, Gx, Gy, Gz);
    end
end
fprintf(FILE,');\n');

% edges declaration 
fprintf(FILE,'\nedges \n( \n\n);\n');

% faces declaration
% bottom declaration 
fprintf(FILE,'\nboundary\n(\n');
fprintf(FILE,'\tbottom \n\t{ \n\t\ttype patch; \n\t\tfaces \n\t\t(');
for i=(length(airfoil)-1)/2+4:length(airfoil)+3
    fprintf(FILE,'\n\t\t\t// block %d LOWER part',i);
    fprintf(FILE,'\n\t\t\t(%d %d %d %d)',block(i).vertexNAME(1),block(i).vertexNAME(2),block(i).vertexNAME(6),block(i).vertexNAME(5)); 
end
fprintf(FILE,'\n\t\t\t// block %d LOWER part',1);
fprintf(FILE,'\n\t\t\t(%d %d %d %d)',block(1).vertexNAME(1),block(1).vertexNAME(2),block(1).vertexNAME(6),block(1).vertexNAME(5));
fprintf(FILE,'\n\t\t); \n\t}');

% top declaration 
fprintf(FILE,'\n\ttop \n\t{ \n\t\ttype patch; \n\t\tfaces \n\t\t(');
for i=2:(length(airfoil)-1)/2+3
    fprintf(FILE,'\n\t\t\t// block %d UPPER part',i);
    fprintf(FILE,'\n\t\t\t(%d %d %d %d)',block(i).vertexNAME(4),block(i).vertexNAME(3),block(i).vertexNAME(7),block(i).vertexNAME(8)); 
end
fprintf(FILE,'\n\t\t); \n\t}');

% inlet declaration 
posU = (length(airfoil)-1)/2+3;
posD = (length(airfoil)-1)/2+4;
fprintf(FILE,'\n\tinlet \n\t{ \n\t\ttype patch; \n\t\tfaces \n\t\t(');
fprintf(FILE,'\n\t\t\t// UPPER block');
fprintf(FILE,'\n\t\t\t(%d %d %d %d)', block(posU).vertexNAME(1), block(posU).vertexNAME(4), block(posU).vertexNAME(8), block(posU).vertexNAME(5));
fprintf(FILE,'\n\t\t\t// LOWER block');
fprintf(FILE,'\n\t\t\t(%d %d %d %d)', block(posD).vertexNAME(1), block(posD).vertexNAME(4), block(posD).vertexNAME(8), block(posD).vertexNAME(5));
fprintf(FILE,'\n\t\t); \n\t}');

% outlet declaration
posU = 2;
posD = 1;
fprintf(FILE,'\n\toutlet \n\t{ \n\t\ttype patch; \n\t\tfaces \n\t\t(');
fprintf(FILE,'\n\t\t\t// UPPER block');
fprintf(FILE,'\n\t\t\t(%d %d %d %d)', block(posU).vertexNAME(2), block(posU).vertexNAME(6), block(posU).vertexNAME(7), block(posU).vertexNAME(3));
fprintf(FILE,'\n\t\t\t// LOWER block');
fprintf(FILE,'\n\t\t\t(%d %d %d %d)', block(posD).vertexNAME(2), block(posD).vertexNAME(6), block(posD).vertexNAME(7), block(posD).vertexNAME(3));
fprintf(FILE,'\n\t\t); \n\t}');

% airfoil surface declaration 
fprintf(FILE,'\n\tairsurface \n\t{ \n\t\ttype wall; \n\t\tfaces \n\t\t(');
for i=3:(length(airfoil)-1)/2+2
    fprintf(FILE,'\n\t\t\t// block %d UPPER part',i);
    fprintf(FILE,'\n\t\t\t(%d %d %d %d)',block(i).vertexNAME(1),block(i).vertexNAME(2),block(i).vertexNAME(6),block(i).vertexNAME(5)); 
end
for i=(length(airfoil)-1)/2+5:length(airfoil)+3
    fprintf(FILE,'\n\t\t\t// block %d LOWER part',i);
    fprintf(FILE,'\n\t\t\t(%d %d %d %d)',block(i).vertexNAME(4),block(i).vertexNAME(3),block(i).vertexNAME(7),block(i).vertexNAME(8)); 
end
fprintf(FILE,'\n\t\t); \n\t}');

fprintf(FILE,'\n);');

% closing file
fclose(FILE);