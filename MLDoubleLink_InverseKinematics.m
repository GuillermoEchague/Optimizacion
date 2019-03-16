%% Inverse Kinematicd for a Two-Link Elbow Manipulator
% This example shows a series of general numerical approaches 
% for finding the solution to the inverse kinematics problem 
% for a two-link elbow manipulator and contrasts the results
% against the known closed form solution for this particular
% case.
%
%%
%
% <<../../Imagenes/TwoLinkIK.jpg>>
%
%% Base parameters
% 
% *set the link dimensions*
rho1 = 0.15; % length of bicep link [m]
rho2 = 0.15; % length of forearm link [m]
%%
% *Define the angle ranges and grid resolution*
th_FullRange = 0:0.05:2*pi;             % full joint angle range [rad]
th1_Range = 45*pi/180:0.05:135*pi/180;  % angle range for bicep link [rad]
th2_Range = 0:0.05:150*pi/180;          % angle range for the forearm link [rad]
%% 
%*set the cartesian location of the desired target*
xdes = -.15;  % x coordinate of the desired target [m]
ydes = .2;    % y coordinate of the desired target [m]
%%
% *Set the initial values for the joint angles*
th_start(1) = 80*pi/180;  %bicep link starting angle [rad]
th_start(2) = 50*pi/180;  %forearm link starting angle [rad]
display(th_start);
%%
% *Compute the forwad kinematics for the given initial angles*
[xtip_0,ytip_0] = fk_doublelink(th_start(1),th_start(2),rho1,rho2);
%%
% *Draw the manipulator in its initial position*
figure;
draw_doublelink(th_start(1),th_start(2),rho1,rho2);
% Superimpose a market on the desired target coordinates
plot(xdes,ydes,'Marker','x','MarkerSize',14,...
     'MarkerEdgeColor','red','LineWidth',2);
text(xdes,ydes - 0.025,'target tip location',...
     'FontAngle','italic',... 	 
	 'HorizontalAlignment','center');
% Superimpose a market on the starting coordinates
plot(xtip_0,ytip_0,'Marker','x','MarkerSize',14,...
	 'MarkerEdgeColor','red','LineWidth',2);
text(xtip_0 + 0.01,ytip_0 + 0.02,'starting tip location',...
	 'FontAngle','italic');
hold off
	 
%% closed form solution
% The solution to the inverse kineatics problem calculates
% the joint angles that will place the tip of the manipulator
% on the desired target location
%
% Using basic geometric calculations, we can find the known
%closed form solution for the two-link elbow manipulator
% case.
%
% *Find the exact solution for the two-link elbow manipulator*
th_exact = ik_doublelink(xdes,ydes,rho1,rho2);
display(th_exact);

%% Numerical optimization methods
% For a more general solution that will work for manipulators
% with a larger number of degrees of freedom, the inverse
% kinematics problem can be re-casted as a nonlinear
% optimization problem where the primary goal is to minimize
% an objetive function that includes a measure of the distance
% between the tip of the manipulator and a desired target
% in the cartesian space, plus any number of appropriate
% additional contraints selected based on design specifications
% or goals (i.e. minimun energy motion, fastest motion, etc),
% the manipulator topology, and the total number of degrees
% of freedom of the mechanism.
% 
% To better illustrate the idea of this optimization concept,
% we will stay in the 2DOF case and we will first calculate
% the distance to a desired target as a function of the entire
% joint angle space for the two-link elbow manipulator.
% 
% *Generate a grid for all possible joint angle space combinations*
[THETA1,THETA2]=meshgrid(th_FullRange, th_FullRange);
%%
% *compute the forward kinematics for all the angle combinations*
[X,Y] = fk_doublelink(THETA1,THETA2,rho1,rho2);
%%
% *Compute the distance to the target for every point on the grid*
Z = distance2target(xdes,ydes,X,Y);
%%
% *Visualize the results*
%
% When looking at the entire joint angle space, we can clearly
% see that for the two-link elbow manipulator topology, there
% are two possible solutions to the problem - in other words,
% two joint angle pairs that make the distance to the target
% minimal.
distance2targetPlot(th_FullRange,Z);
%%
% *Constrain the analysis*
%
% We will now focus only on the joint angle space region
% Where there is a valid angle pair solution for our two-link
% elbow manipulator problem.
%
% *Re-generate the grid for only the valid angle combinations*
[THETA1,THETA2] = meshgrid(th1_Range, th2_Range);
%%
% *Compute the forward kinematics for all the valid angle combinations*
[X,Y] = fk_doublelink(THETA1,THETA2,rho1,rho2);
%%
%*Compute the distance to the target for every point on the new grid*
Z = distance2target(xdes,ydes,X,Y);
%%
% *Visualize the feasible region*
%
% Notice that in this case, When we constrain the joint
% angle space to the valid angle region, we are left with
% only one possible solution for our problem.
feasibleregionPlot(th1_Range, th2_Range,Z);
 hold on
% Superimpose a marker on the starting joint angle pair
plot(th_start(1),th_start(2),'Marker','x','MarkerSize',12,...
     'MarkerEdgeColor','red','LineWidth',2);
text(th_start(1) + 0.05,th_start(2),'starting joint angles',...
    'FontAngle','italic','Color','red');
% Superimpose a marker on the solution joint angle pair
plot(th_exact(1),th_exact(2),'Marker','x','MarkerSize',12,...
    'MarkerEdgeColor','red','LineWidth',2);
text(th_exact(1) + 0.05,th_exact(2),'closed form solution',...
    'FontAngle','italic','Color','red');
 hold off
%%
% *Solve using constrained minimization*
%
% Using the built-in optimization toolbox function FMINCON
[th_opt,iter] = optimize_ik(th_start,xdes,ydes,rho1,rho2,...
    th1_Range,th2_Range);
display(th_opt);
display(iter);

%%
% As you can observe, the algorithms available in FMINCON,
% as well as all other functions in the Optimization and
% Global Optimization Toolboxes are quite powerfull and they
% can quite readily solve our problem.
% 
% The main limitation of this approch would come frome the
% need to either connect and test the algorith in a full
% dynamic simulation of our system (i,e, bring it into
% the simulink environment) or eventually embed it on
% a real-time micro-controler, wich would require us to
% be able to generate C-code from it.
% 
% With this in mind, and solely for illustrative purposes,
% we will show a couple of very simple alternate
% implementtions of a gradient search optimization
% algoritms that are fully compliant with EMBEDED MatLab,
% and hence can be easily brought into Siulink and
% automatically translated into C code.
%%
% *Solve using an approximate gradient search method*
[th_gr1,iter] = mygradientsearch1(th_start,xdes,ydes,...
    rho1,rho2,th1_Range,th2_Range);
display(th_gr1);
display(iter);
%%
% *Solve using an approximate gradient with momentum correction method*
[th_gr2,iter] = mygradientsearch3(th_start,xdes,ydes,...
    rho1,rho2,th1_Range,th2_Range);
display(th_gr2);
display(iter);
%% Inference methods
% As the third and final approach we present an alternative
% and very popular method to solve the inverse kinematics
% problem.
% 
% Using the fact the forward kinematics equations for
% a multi-link robotics manipulator are known and well
% defined, inference methods that use fuzzy logic or neural
% nets can be apllied to deduce the inverse kinematics without
% the need for developing an analytic solution to the problem.
% 
% For the two-link elbow manipulator example, we will
% construct a Fuzzy Inference System that will map all the
% feasible locations of the tip of the manipulator in the
% cartesian space to their corresponding joint angle pair in
% the joint angle space
%%
% *Display all the valid locations for the tip of the manipulator*
% 
% plot the entire valid range of motion for the tip of the
% two-link elbow  manipulator in the cartesian space calculated
% using the forward kinematics equations.
% 
% $x_2 =\rho_1 cos(\theta_1)+ \rho_2 cos(\theta_1+\theta_2)$
% 
% $y_2 =\rho_1 sin(\theta_1)+ \rho_2 sin(\theta_1+\theta_2)$
% 
figure;
plot(X(:),Y(:),'.','Color',[205/255 205/255 205/255]);
hold on;
% Draw the manipulator in its initial position
drawlight_doublelink(th_start(1),th_start(2),rho1,rho2);
hold on;
% Draw the manipulator in its final position
drawlight_doublelink(th_exact(1),th_exact(2),rho1,rho2);
% Superimpose a marker on the desired target coordinates
plot(xdes,ydes,'Marker','X','MarkerSize',14,...
    'MarkerEdgeColor','red','LineWidth',2);
text(xdes,ydes - 0.025,'target tip location',...
    'FontAngle','italtic',...
    'HorizontalAlignment','center');
% Superimpose a marker on the starting coordinates
plot(xtip_0,ytip_0,'Marker','x','MarkerSize',14,...
    'MarkerEdgeColor','red','LineWidth',2);
text(xtip_0+0.01,ytip_0+0.02,'starting tip location',...
    'FontAngle','italic');
hold off 
%%
% *Create the training datasets*
data1 = [X(:) Y(:) THETA1(:)]; % x-y-theta1 dataset
data2 = [X(:) Y(:) THETA2(:)]; % x-y-theta2 dataset 
%%
% *Build the ANFIS networks*
%
% The ANFIS (Adaptive Neuro-Fuzzy Inference System) function
% will automatically train the networks using the given
% training input-output datasets. For our case, the cartesian
% cordinates of the tip of the manipulator x and y act as
% the input to the networks, ant the joint angles theta1 and
% theta2 act as the indeoendently predicted outputs. 
%
% The second input parameter to the fuction is the number of
% fuzzy membership functions used to characterize each input
% and output ant the third input parameter is the number of
% epchs used for training.
%
% NOTE: depending on your computer this calculation might
%take a couple of minutes.
% Alternatively, you can just comment the next five lines,
% and load the results directly by uncommenting the last line
% in the cell
tic;
display('Training first ANFIS network...')
anfis1 = anfis(data1,9,22,[0,0,0,0]); % train first ANFIS network
display('Training second ANFIS network...')
anfis2 = anfis(data2,9,22,[0,0,0,0]); % train second ANFIS network
display('Done');
toc
% load('anfis_nets'); 
%%
% *Use the ANFIS networks to predict the manipulator joint angle*
th_fis(1) = evalfis([xdes,ydes], anfis1); % theta1 predictive by anfis1
th_fis(2) = evalfis([xdes,ydes], anfis2); % theta2 predictive by anfis2
display(th_fis);
%%
% *Validate the ANFIS networks*
%
% We will select a region in the cartesian space to test and 
% Validate our ANFIS networks. We will compare the results
% against the knwo closedf for solution for our two-link
% elbow manipulator
%%
% Define the region of interest in the cartesian space
x = -0.2:.005:-0.1;
y = 0:0.005:0.2;
%%
% Find the closed form (exact) solution to the inverse
% kinematics problem for a two-link elbow manipulator
[XT,YT] = meshgrid(x,y);
TH_EXACT = ik_doublelink(XT,YT,rho1,rho2);
THETA1x = TH_EXACT(:,1:length(x));
THETA2x = TH_EXACT(:,length(x)+1:end);
%%
% Create testing datasets
test1 = [XT(:) YT(:) THETA1x(:)]; % x-y-theta1 dataset
test2 = [XT(:) YT(:) THETA2x(:)]; % x-y-theta2 dataset
%%
% Evaluate the ANFIS networks
XY = [XT(:) YT(:)];
THETA1p = evalfis(XY, anfis1); % bicep link joint angle predicted by anfis1
THETA2p = evalfis(XY, anfis2); % forearm link joint angle predicted by anfis2
%%
% Compute the devitation from the exact solution
th1_error = THETA1x(:)-THETA1p;
th2_error = THETA2x(:)-THETA2p;
%%
% Visualize the results
figure;
subplot(2,1,1);
plot(th1_error,'color',[244/255 192/255 192/255],...
    'LineWidth',2);
xlabel('Samples');    
ylabel('\theta_1_{exact} - \theta_1_{predicted} [rad]');
title('Bicep Link Joint Angle Error - Exact vs Predicted',...
    'FontSize',11);
axis tight;
grid on;
%
subplot(2,1,2);
plot(th2_error,'color',[149/255 179/255 215/255],...
    'LineWidth',2);
xlabel('Samples');    
ylabel('\theta_2_e_x_a_c_t - \theta_2_p_r_e_d_i_c_t_e_d [rad]');
title('Forearm Link Joint Angle Error - Exact vs Predicted',...
    'FontSize',11);
axis tight;
grid on;
% EOF