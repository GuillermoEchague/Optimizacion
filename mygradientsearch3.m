function [th02,opt2] = mygradientsearch3(th_start,xd,yd,l1,l2,th1r,th2r)

% Set up the initial plot
% Generate a grid for all angle combinations
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

% Initialize the optimization
dist = calc_dist(th_start(1),th_start(2),xd,yd,l1,l2);
th1 = th_start(1);
th2 = th_start(2);
grad = zeros(1,2);
i = 0;
j = 0;

% Initialize the marker plotting function
hplot = plot(th1,th2,'LineStyle','none',...
    'Marker','x','MarkerSize',12,...
    'MarkerEdgeColor','red','LineWidth',2);
drawnow;
xdata = th1;
ydata = th2;

% Gradient search algorithm - by measurement
while (dist > 1e-6)
    % Update the data for the marker plot every 4 iterations
    xdata(i+1) = th1;
    ydata(i+1) = th2;
    i = i+1;
    if j >= 4
        set(hplot,'Xdata',xdata,'Ydata',ydata);
        drawnow;
        j=0;
    end
    dx=1.9;
    dy=.5;
    % Approximate the gradient by measuremnt
    grad(1) = (calc_dist(th1 + dx,th2,xd,yd,l1,l2)...
        -calc_dist(th1 - dx,th2,xd,yd,l1,l2))/(2*dx);
    grad(2) = (calc_dist(th1,th2 + dy,xd,yd,l1,l2)...
        -calc_dist(th1,th2 - dy,xd,yd,l1,l2))/(2*dy);
    
   H(1) = grad(1)-2*calc_dist(th1,th2,xd,yd,l1,l2)/dx.^2;
   H(2) = grad(2)-2*calc_dist(th1,th2,xd,yd,l1,l2)/dy.^2;
   H(3) =(calc_dist(th1 + dx,th2 + dy,xd,yd,l1,l2)-...
          calc_dist(th1 + dx,th2 - dy,xd,yd,l1,l2)-...
          calc_dist(th1 - dx,th2 + dy,xd,yd,l1,l2)+...
          calc_dist(th1 - dx,th2 - dy,xd,yd,l1,l2))/(4*dx*dy);
   H =H(1)*H(2)-(H(3)).^2;  
    
    % Update the optimization variables
    th1 = th1 - H*grad(1);
    th2 = th2 - H*grad(2);
  hplot = plot(th1,th2,'LineStyle','none',...
     'Marker','x','MarkerSize',12,...
     'MarkerEdgeColor','red','LineWidth',2);
drawnow;
  
xc =l1*cos(th1)+l2*cos(th1+th2);
yc = l1*sin(th1)+l2*sin(th1+th2);
dist = sqrt((xd-xc).^2+(yd-yc).^2); 

end
plot(th1,th2,'Marker','+','MarkerSize',10,...
    'MarkerEdgeColor','yellow','LineWidth',2);
text(th1 + 0.05,th2,'final point',...
    'FontAngle','italic','Color','yellow');
th02 = [th1,th2];
opt2 =i;