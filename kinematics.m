clear 
clc

%---------------------------------------------------------------
%Variables going into Miura3D function
alpha_1 = deg2rad([30,135]);
alpha_2 = deg2rad([60,120]);
theta = deg2rad(45);
baseDir=[0 1 0];

%---------------------------------------------------------------
%Variables for plotting
linkLength=[1,1,1,1,1,1,1,1];
color = {'b','g','r','y','k','c','m'};
links=2;

%---------------------------------------------------------------
%Variables for initial link
iPoint=[0;0;0];     
vertex=iPoint;

%---------------------------------------------------------------
% Plotting 

for i = 1:links 
    [B,C,D,phi,psi] = Miura3D(alpha_1(i), alpha_2(i), theta, baseDir);
    fPoint=iPoint+linkLength(i)*D;
    vertex=[vertex fPoint];
    
    Ld = line([iPoint(1),fPoint(1)],[iPoint(2),fPoint(2)],[iPoint(3),fPoint(3)]);
    Ld.Color = color{i};
 
    axis([-2 2 -2 2 0 4])
    grid on
    hold on
    xlabel('x');
    ylabel('y');
    zlabel('z');
    
    baseDir=D;   
    iPoint=fPoint;
    theta=-theta;
end
vertex
norm(vertex(:,i+1))
hold off