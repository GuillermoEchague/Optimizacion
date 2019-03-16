function [th,iter] = optimize_GA(th0,xd,yd,l1,l2,th1r,th2r)
% This is an auto generated MatLab file from optimization Tool.
% Set up the initial plot
% Generate a grid for all angle combinations
[TH1,TH2] = meshgrid(th1r,th2r);
% Compute the distance to the target for every point on the grid
Z = calc_dist(TH1,TH2,xd,yd,l1,l2);
% Plot the results
feasibleregionPlot(th1r,th2r,Z);
colormap('bone');
hold on;
% % Superimpose a marker on the starting point
% plot(th_start(1),th_start(2),'Marker','+','MarkerSize',10,...
%     'MarkerEdgeColor','yellow','LineWidth',2);
% text(th_start(1) + 0.05,th_start(2),'starting point',...
%     'FontAngle','italic','Color','yellow');
% Added manually
% lb = [min(th1r),min(th2r)];
% ub = [max(th1r),max(th2r)];
th0= repmat(th0,100,1);

% Solve using Genetic Algorithm
[th0 fval flag] = ga(@(th)objfun_doublelink(th,xd,yd,l1,l2),2,[],[],[],[],[],[],[],options);

