function distance2targetPlot(th_FullRange,Z)

figure1=figure;
subplot1 =subplot(1,2,1,'Parent',figure1);
view(subplot1,[-29.5 66]);
grid(subplot1,'on');
hold(subplot1,'all');
surf(Z,'Parent',subplot1,'LineStyle','none','FaceColor','interp',...
    'DisplayName','Z');
title('Joint Angle Space');
xlabel('\theta_1 (rad)');
ylabel('\theta_2 (rad)');
zlabel('Distance to target (m)');
axes1 = axes('Parent',figure1,...
    'Position',[0.570340909090909 0.11 0.263659090909091 0.815]);
box(axes1,'on');
hold(axes1,'all');
contour(Z,'Fill','on','DisplayName','Z','Parent',axes1);
colorbar('peer',axes1);
xlabel('\theta_1 (rad)');
ylabel('\theta_2 (rad)');
set(axes1,'Position',[0.570340909090909 0.11 0.263659090909091 0.815]);