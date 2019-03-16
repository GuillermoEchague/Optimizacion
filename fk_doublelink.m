function [xt,yt] = fk_doublelink(th1,th2,l1,l2)
% This function evaluates the forward kinematics equation
% for a two-link elbow manipulator and returns the cartes
% coordinate location for the tip of the manipulator
%
% Inputs:
%  th1 : first link or bicep angle [rad]
%  th2 : second link or forearm angle [rad]
% l1 : first link or bicep length [m]
% l2 : second link or forearm length [m]
% Outputs:
% xt : x coordinate of the tip of the manipulator [m]
% yt : y coordinate of the tip of the manipulator [m]
%

% Evaluate the forward kinematics equations for a double
% link elbow manipulator
xt = l1*cos(th1)+l2*cos(th1+th2);
yt = l1*sin(th1)+l2*sin(th1+th2);