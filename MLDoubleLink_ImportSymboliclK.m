%% Import Symbolic Equation into Simulink
% This script show how to import symbolicc expressions
% from MUPad notebook derivation directly into Simulink
% by using the Embedded MatLab block option
%
%% Open the Simulink model
% Open the Motion Control of Two-Link Elbow Manipulator
% Simulink model
open('SMDoubleLinkSYM.mdl')

%%Open the MUPad notebook
% Open the MUPad notebook where the Inverse Kinematics
% equations are derived
nb = mupad('MUInversekinematics.mn');

%% Read the symbolic expessions from MatLab
% Read the symbolic expressions corresponding to the
% desired manipulador angles theta1 and theta2 from the
% notebook
% NOTE: you MUST EVALUATE THE NOTEBOOK manually before attempting
% to read the variables from MatLab
th2des = getVar(nb,'TH2des');
th1des = getVar(nb,'TH1des');

%% Generate Embedded MatLab blocks
% Two blocks will appear in teh appropriate subsystem in the model
matlabFunctionBlock('SMDoubleLinkSYM/Inverse Kinematics/calcTH1des',th1des);
set_param('SMDoubleLinkSYM/Inverse Kinematics/calcTH1des',...
           'Position',[340,48,480,132],...
           'BackgroundColor','[192/255,192/255,192/255]');  
matlabFunctionBlock('SMDoubleLinkSYM/Inverse Kinematics/calcTH2des',th2des);
set_param('SMDoubleLinkSYM/Inverse Kinematics/calcTH1des',...
           'Position',[340,178,480,262],...
           'BackgroundColor','[192/255,192/255,192/255]');
		   open_syste('SMDoubleLinkSYM/Inverse Kinematics')
		   %EOF