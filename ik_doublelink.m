function thx = ik_doublelink(xd,yd,l1,l2)
% This function finds the exact solution for the inverse
% kinematics equations for a two-link elbow manipulator
% and returns the joint angle pair corresponding to the
% given desired target point
%
% Inputs:
%  xd    : x coordinate of the tip of the manipulator [m]
%  yd    : y coordinate of the tip of the manipulator [m]
%  l1    : first link or bicep length [m]
%  l2    : second link or forearm angle [rad]
% Outputs:
%  thx(1) : first link or bicep angle [rad]
%  thx(2) : second link or forearm angle [rad]
%

% Calculate the forearm link angle
c2 = (xd.^2+yd.^2-l1^2-l2^2)/(2*l1*l2);
s2 = sqrt(1-c2.^2);
thx2 = atan2(s2,c2);

% Calculate the bicep link angle
k1 = l1+l2*c2;
k2 = l2*s2;
thx1 = atan2(yd,xd) - atan2(k2,k1);

%Combine in a single output vector
thx= [thx1,thx2];