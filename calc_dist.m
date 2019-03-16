function th = calc_dist(TH1,TH2,xd,yd,l1,l2)

xc = l1*cos(TH1)+l2*cos(TH1+TH2);
yc = l1*sin(TH1)+l2*sin(TH1+TH2);


% % Calculate the forearm link angle
% c2 = (xc.^2+yc.^2-l1^2-l2^2)/(2*l1*l2);
% s2 = sqrt(1-c2.^2);
% th2 = atan2(s2,c2);
% 
% % Calculate the bicep link angle
% k1 = l1+l2*c2;
% k2 = l2*s2;
% th1 = atan2(yc,xc) - atan2(k2,k1);
% 
% % Calculate the forearm link angle
% c2 = (xd.^2+yd.^2-l1^2-l2^2)/(2*l1*l2);
% s2 = sqrt(1-c2.^2);
% thx2 = atan2(s2,c2);
% 
% % Calculate the bicep link angle
% k1 = l1+l2*c2;
% k2 = l2*s2;
% thx1 = atan2(yd,xd) - atan2(k2,k1);
% 
% %Combine in a single output vector
% % th = [thc1-thx1,thc2-thx2];
th = sqrt((xd-xc).^2+(yd-yc).^2);