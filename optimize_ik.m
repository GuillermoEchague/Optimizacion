function [th,iter] = optimize_ik(th0,xd,yd,l1,l2,l3,th1r,th2r,th3r)
% This is an auto generated MatLab file from optimization Tool.
tic;
% Added manually
lb = [min(th1r),min(th2r)];
ub = [max(th2r),max(th3r)];

% Start with the default options
options = optimset;
% Modify options setting
options = optimset(options,'Display','off');
% options = optimset(options,'OutputFcn',...
%         {@(th,arg1,arg2)plotfun_doublelink(th,arg1,arg2,xd,yd,l1,l2,th1r,th2r)});
% options = optimoptions('fmincon','Algorithm','interior-point',...
%     'Display','iter','OutputFcn',@plotfun_doublelink);
options = optimset(options,'Algorithm','sqp');
[th,~,~,out] = fmincon(@(th)objfun_doublelink(th,xd,yd,l1,l2,l3),...
     th0,[],[],[],[],lb,ub,[],options);
iter = out.iterations; % Devuelve el numero de iteraciones de out
toc;