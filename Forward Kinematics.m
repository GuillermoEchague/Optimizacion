%% Forward Kinematics
rho1=0.15;
rho2=0.15;
theta1=45*pi/180:0.05:135*pi/180;
theta2=0:0.05:150*pi/180;
x=rho1*cos(th1)+rho2*cos(th1+th2);
y=rho1*sin(th1)+rho2*sin(th1+th2);
%% Define full range
[THETA1,THETA2]=meshgrid(theta1,theta2);
Y=rho1*sin(THETA1)+rho2*sin(THETA1+THETA2);
X=rho1*cos(THETA1)+rho2*cos(THETA1+THETA2);
%% Display result
plot(X,Y,'r.')
axis equal
