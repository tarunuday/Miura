function [B,C,D,phi,psi] = Miura3D( alpha_1, alpha_2, theta, baseDir)

%assert(norm(baseDir)==1,'baseDir is not in unit vector format');

%----------------------
b_x0 = sin(alpha_1);
b_y0 = cos(alpha_1);
b_x = b_x0*cos(theta);
b_y = b_y0;
b_z = b_x0*sin(theta);

if alpha_1 > pi*(90)/180
    B = [b_x b_y b_z];
else
    B = [b_x b_y b_z];
end 
 

c_x0 = sin(alpha_2);
c_y0 = cos(alpha_2);
c_x = -c_x0*cos(theta);
c_y = c_y0;
c_z = c_x0*sin(theta);

if alpha_2 > pi*(90)/180
    C = [c_x c_y c_z];
else
    C = [c_x c_y c_z];
end 

%----------------------

K_1 = 1/tan(alpha_1) + 1/tan(alpha_2);
K_2 = 1/tan(alpha_1) - 1/tan(alpha_2);

denominator = 4*sin(theta)^2 + K_2^2*tan(theta)^2 + K_1^2;
numerator = 4*K_1*sin(theta);

d_z = numerator/denominator;
d_x = d_z*(K_2/K_1)*tan(theta);
d_y = sqrt(1 - d_x^2 - d_z^2);

D = [d_x d_y d_z];

%-------------------------

D_comp_z = [d_x d_y 0];
cosPhi = dot(D,D_comp_z)/(norm(D)*norm(D_comp_z));
phi = acos(cosPhi);

D_comp_x = [0 d_y d_z];
cosPsi = dot(D,D_comp_x)/(norm(D)*norm(D_comp_x));
psi = acos(cosPsi);

%--------------------------

E = cross(D,B);
F = cross(C,D);

u_z = (E + F)/norm(E+F);
u_y = D;
u = [cross(u_y,u_z),u_y,u_z];

%--------------------------

axang = [cross(baseDir,[0 1 0]) -acos(dot(baseDir,[0 1 0]))]
if axang==[0,0,0,0]
    rotm=eye(3);
else
    rotm = axang2rotm(axang);
end

B=rotm*B';
C=rotm*C';
D=rotm*D';

end