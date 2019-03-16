function z = objfun_doublelink(th,xd,yd,a1,a2,a3)

% xt = l1*cos(th(1))+l2*cos(th(1)+th(2));
% yt = l1*sin(th(1))+l2*sin(th(1)+th(2));
yt =a2*cosd(th(1)+th(2)-th(3))+a3*cosd(th(1)+th(2)-th(3))+a1*cosd(th(1)+th(2)); 
xt =a2*sind(th(1)+th(2)-th(3))+a3*sind(th(1)+th(2)-th(3))+a1*sind(th(1)+th(2));


x=xd-xt;
y=yd-yt;
z = sqrt(x.^2+y.^2);