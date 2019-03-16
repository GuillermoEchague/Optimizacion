function feasibleregionPlot(th1_Range,th2_Range,th3_Range,Z)
figure;
grid('on');
xlabel('\theta_1 (rad)');
ylabel('\theta_2 (rad)');
contourf(th1_Range,th2_Range,th3_Range,Z);
% contour(Z,'Fill','on', 'DisplayName','Z');


