function Z = distance2target(xd,yd,xc,yc)
% This function calculates the distance from a current position
% in the cartesian space to a desired target location in the
% same space
% Inputs:
% xd, yd : cartesian coordinates of the desired target
% xc, yc : cartesian coordinates of the current position
% Output:
%  Z : distance between the points
%

% Compute the distance to the desired target from the given
% current location
Z = sqrt((xd-xc).^2+(yd-yc).^2);