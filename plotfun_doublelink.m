function plotfun_doublelink(th_start,xd,yd,l1,l2,th1r,th2r)

%Generate a grid for all angle combinations
[TH1,TH2] = meshgrid(th1r,th2r);
% Compute the distance to the target for every point on the grid
Z = calc_dist(TH1,TH2,xd,yd,l1,l2);
% Plot the results
feasibleregionPlot(th1r,th2r,Z);
colormap('bone');
hold on;
% Superimpose a marker on the starting point
plot(th_start(1),th_start(2),'Marker','+','MarkerSize',10,...
    'MarkerEdgeColor','yellow','LineWidth',2);
text(th_start(1) + 0.05,th_start(2),'starting point',...
    'FontAngle','italic','Color','yellow');

%   % Update the optimization variables
%     th1 = arg1;
%     th2 = arg2;
%   hplot = plot(th1,th2,'LineStyle','none',...
%      'Marker','x','MarkerSize',12,...
%      'MarkerEdgeColor','red','LineWidth',2);
% drawnow;

% 
% Finalize the marker plotting function
plot(th1,th2,'Marker','+','MarkerSize',10,...
    'MarkerEdgeColor','yellow','LineWidth',2);
text(th1 + 0.05,th2,'final point',...
    'FontAngle','italic','Color','yellow');