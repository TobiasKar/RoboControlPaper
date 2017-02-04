%% 2 DOF Planar Robot
clear all;
syms q1 q1d q1dd q2 q2d q2dd m1 m2 a1 a2 g b1 b2 tau1 tau2 tau_d1 tau_d2

q = [q1; q2];
qd = [q1d; q2d];
qdd = [q1dd; q2dd];

r1 = [a1*cos(q1); a1*sin(q1)];
r2 = r1 + [a2*cos(q1+q2); a2*sin(q1+q2)];

r1d = jacobian(r1, q)*qd;
r2d = jacobian(r2, q)*qd;

Ek = simplify(m1/2*(r1d.'*r1d) + m2/2*(r2d.'*r2d));
Ep = m1*g*r1(2) + m2*g*r2(2);

% P = b1/2 * q1d^2 + b2/2 * q2d^2;
P = 0;
Q = [tau1 tau2].';
tau_d = [tau_d1 tau_d2].';

L = simplify(Ek - Ep);

Lag = simplify(jacobian(jacobian(L, qd), [q; qd])*[qd; qdd] - jacobian(L, q).' - Q + jacobian(P, qd).');
% sol_ode = solve(Lag, q1dd, q2dd);

M = simplify(expand(jacobian(Lag, qdd)));
% N = -simplify(M*qdd - Lag - Q);
child = children(Lag);
child1 = child{1}((diff(child{1}, q1d)~=0) | (diff(child{1}, q2d)~=0));
child2 = child{2}(diff(child{2}, q1d)~=0 | diff(child{2}, q2d)~=0);
V = [sum(child1); sum(child2)];
V2_sym = [-2*a1*a2*m2*q2d*sin(q2)  -a1*a2*m2*q2d*sin(q2); a1*a2*m2*q1d*sin(q2) 0];

G1 = simplify(Lag - M*qdd - V + Q);

N = V + G1;

eq =simplify( M\(-N + Q - tau_d));

eq1 = subs(eq(1), {q1, q2, q1d, q2d, tau1, tau2, tau_d1, tau_d2}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'tau_d(1)', 'tau_d(2)'});
eq2 = subs(eq(2), {q1, q2, q1d, q2d, tau1, tau2, tau_d1, tau_d2}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'tau_d(1)', 'tau_d(2)'});

expression = {'\\mathrm{(\w*)}'; '\\,'; '\<(?![\])(.)(\d+)(d+)'; 'tau'; '(\w*)(?=\d)'; '(?<=\\left\()((?x:\S*?))(?=\\right\))'};
replace = {'$1'; ''; '\\$3ot{$1}\_{$2}'; '\\tau'; '$1\_'; '$1'};

% eq2latexeq(regexprep(latex(Lag(1)), expression, replace), 'report/equations/planar_robot1.tex');
% eq2latexeq(regexprep(latex(Lag(2)), expression, replace), 'report/equations/planar_robot2.tex');
eq2latexeq(regexprep(latex(M), expression, replace), 'report/equations/planar_robot_M.tex');
eq2latexeq(regexprep(latex(V), expression, replace), 'report/equations/planar_robot_v.tex');
eq2latexeq(regexprep(latex(G1), expression, replace), 'report/equations/planar_robot_g.tex');
eq2latexeq(regexprep(latex(jacobian(r2, q)), expression, replace), 'report/equations/planar_robot_jacobian.tex');

%% System simulation file

fid = fopen('planar_robot_simulink.m', 'w');
fprintf(fid, 'function [qd] = planar_robot_simulink(u_gen)\n');
fprintf(fid, '%% Usage: [qd] = planar_robot_simulink(u_gen)\n');
fprintf(fid, '%%        u_gen: [q, tau, m1, m2, a1, a2, b1, b2, g, tau_d]\n');
fprintf(fid, '%% generated by planar_robot_2dof.m for planar_robot_simulation.slx\n\n');

fprintf(fid, 'q = u_gen(1:4);\n');
fprintf(fid, 'qd = zeros(4,1);\n');
fprintf(fid, 'tau = u_gen(5:6);\n');
fprintf(fid, 'm1 = u_gen(7);\n');
fprintf(fid, 'm2 = u_gen(8);\n');
fprintf(fid, 'a1 = u_gen(9);\n');
fprintf(fid, 'a2 = u_gen(10);\n');
fprintf(fid, 'b1 = u_gen(11);\n');
fprintf(fid, 'b2 = u_gen(12);\n');
fprintf(fid, 'g = u_gen(13);\n\n');
fprintf(fid, 'tau_d = u_gen(14:15);\n\n');

fprintf(fid, 'qd(1) = q(3);\n');
fprintf(fid, 'qd(2) = q(4);\n');
fprintf(fid, ['qd(3) = ', char(eq1),';\n']);
fprintf(fid, ['qd(4) = ', char(eq2),';\n']);
fclose(fid);

%%
clear m1 m2 a1 a2 b1 b2 g
m1 = 1;
m2 = 1;
a1 = 1;
a2 = 1;
b1 = 0;
b2 = 0;
g = 9.81;

%% CT PD Controller

syms q1dd_des q1d_des q1_des q2dd_des q2d_des q2_des

q_des = [q1_des; q2_des];
qd_des = [q1d_des; q2d_des];
qdd_des = [q1dd_des; q2dd_des];

zeta = 1;
wn = 10;

kv = 2*zeta*wn;
kp = wn^2;

ct_cont = M*(qdd_des + kv*(qd_des - qd) + kp*(q_des - q)) + N;

ct1 = subs(ct_cont(1), {q1, q2, q1d, q2d, tau1, tau2, q1_des, q2_des, q1d_des, q2d_des, q1dd_des, q2dd_des}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'q_des(1)', 'q_des(2)', 'q_des(3)', 'q_des(4)', 'q_des(5)', 'q_des(6)'});
ct2 = subs(ct_cont(2), {q1, q2, q1d, q2d, tau1, tau2, q1_des, q2_des, q1d_des, q2d_des, q1dd_des, q2dd_des}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'q_des(1)', 'q_des(2)', 'q_des(3)', 'q_des(4)', 'q_des(5)', 'q_des(6)'});

%% Controller Simulation file

fid = fopen('ct_planar_robot_simulink.m', 'w');
fprintf(fid, 'function [tauc] = ct_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%% Usage: [tauc] = ct_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%%        u_gen: [q, q_des, m1, m2, a1, a2, b1, b2, g]\n');
fprintf(fid, '%% generated by planar_robot_2dof.m for planar_robot_simulation.slx\n\n');

fprintf(fid, 'q = u_gen(1:4);\n');
fprintf(fid, 'tauc = zeros(2,1);\n');
fprintf(fid, 'q_des = u_gen(5:10);\n');
fprintf(fid, 'm1 = u_gen(11);\n');
fprintf(fid, 'm2 = u_gen(12);\n');
fprintf(fid, 'a1 = u_gen(13);\n');
fprintf(fid, 'a2 = u_gen(14);\n');
fprintf(fid, 'b1 = u_gen(15);\n');
fprintf(fid, 'b2 = u_gen(16);\n');
fprintf(fid, 'g = u_gen(17);\n\n');

fprintf(fid, ['tauc(1) = ', char(ct1),';\n']);
fprintf(fid, ['tauc(2) = ', char(ct2),';\n']);
fclose(fid);

%% Trajectory file

syms t;

T = 2;
k = 0.1;

qdes1 = k*sin(2*pi*t/T);
qdes2 = k*cos(2*pi*t/T);

qdes1_d = diff(qdes1, t);
qdes2_d = diff(qdes2, t);

qdes1_dd = diff(qdes1_d, t);
qdes2_dd = diff(qdes2_d, t);

fid = fopen('trajectory_planar_robot_simulink.m', 'w');
fprintf(fid, 'function [qdes] = trajectory_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%% Usage: [qdes] = trajectory_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%%        u_gen: [t]\n');
fprintf(fid, '%% generated by planar_robot_2dof.m for planar_robot_simulation.slx\n\n');

fprintf(fid, 't = u_gen(1);\n');
fprintf(fid, 'qdes = zeros(6,1);\n');

fprintf(fid, ['qdes(1) = ', char(qdes1),';\n']);
fprintf(fid, ['qdes(2) = ', char(qdes2),';\n']);
fprintf(fid, ['qdes(3) = ', char(qdes1_d),';\n']);
fprintf(fid, ['qdes(4) = ', char(qdes2_d),';\n']);
fprintf(fid, ['qdes(5) = ', char(qdes1_dd),';\n']);
fprintf(fid, ['qdes(6) = ', char(qdes2_dd),';\n']);
fclose(fid);

%% CT PID Controller

syms eps1 eps2

epsi = [eps1; eps2];

zeta = 1;
wn = 8;
% po = 20;

% ki = wn^2*po;
ki = 500;
po = ki/wn^2;
kv = 2*zeta*wn + po;
kp = 2*zeta*wn*po + wn^2;

ct_cont = M*(qdd_des + ki * epsi + kv*(qd_des - qd) + kp*(q_des - q)) + N;

ct1 = subs(ct_cont(1), {q1, q2, q1d, q2d, tau1, tau2, q1_des, q2_des, q1d_des, q2d_des, q1dd_des, q2dd_des, eps1, eps2}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'q_des(1)', 'q_des(2)', 'q_des(3)', 'q_des(4)', 'q_des(5)', 'q_des(6)', 'eps(1)', 'eps(2)'});
ct2 = subs(ct_cont(2), {q1, q2, q1d, q2d, tau1, tau2, q1_des, q2_des, q1d_des, q2d_des, q1dd_des, q2dd_des, eps1, eps2}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'q_des(1)', 'q_des(2)', 'q_des(3)', 'q_des(4)', 'q_des(5)', 'q_des(6)', 'eps(1)', 'eps(2)'});

%% Controller Simulation file

fid = fopen('ct_pid_planar_robot_simulink.m', 'w');
fprintf(fid, 'function [tauc] = ct_pid_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%% Usage: [tauc] = ct_pid_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%%        u_gen: [q, eps, q_des, m1, m2, a1, a2, b1, b2, g]\n');
fprintf(fid, '%% generated by planar_robot_2dof.m for planar_robot_simulation.slx\n\n');

fprintf(fid, 'q = u_gen(1:4);\n');
fprintf(fid, 'eps = u_gen(5:6);\n');
fprintf(fid, 'tauc = zeros(2,1);\n');
fprintf(fid, 'q_des = u_gen(7:12);\n');
fprintf(fid, 'm1 = u_gen(13);\n');
fprintf(fid, 'm2 = u_gen(14);\n');
fprintf(fid, 'a1 = u_gen(15);\n');
fprintf(fid, 'a2 = u_gen(16);\n');
fprintf(fid, 'b1 = u_gen(17);\n');
fprintf(fid, 'b2 = u_gen(18);\n');
fprintf(fid, 'g = u_gen(19);\n\n');

fprintf(fid, ['tauc(1) = ', char(ct1),';\n']);
fprintf(fid, ['tauc(2) = ', char(ct2),';\n']);
fclose(fid);

%% 
% G = simplify(N - jacobian(N, qd)*qd)
G = [(m1+m2)*g*a1*cos(q1)+m2*g*a2*cos(q1+q2);
     m2*g*a2*cos(q1+q2)];
 
wn = 10;
zeta = 1;
kp = wn^2;
kv = 2*zeta*wn;

ct_gravit = kv*(qd_des - qd) + kp*(q_des - q) + G;
ctg1 = subs(ct_gravit(1), {q1, q2, q1d, q2d, tau1, tau2, q1_des, q2_des, q1d_des, q2d_des, q1dd_des, q2dd_des, eps1, eps2}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'q_des(1)', 'q_des(2)', 'q_des(3)', 'q_des(4)', 'q_des(5)', 'q_des(6)', 'eps(1)', 'eps(2)'});
ctg2 = subs(ct_gravit(2), {q1, q2, q1d, q2d, tau1, tau2, q1_des, q2_des, q1d_des, q2d_des, q1dd_des, q2dd_des, eps1, eps2}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'q_des(1)', 'q_des(2)', 'q_des(3)', 'q_des(4)', 'q_des(5)', 'q_des(6)', 'eps(1)', 'eps(2)'});


%% Controller Simulation file Gravit

fid = fopen('ct_gravit_planar_robot_simulink.m', 'w');
fprintf(fid, 'function [tauc] = ct_gravit_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%% Usage: [tauc] = ct_gravit_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%%        u_gen: [q, q_des, m1, m2, a1, a2, b1, b2, g]\n');
fprintf(fid, '%% generated by planar_robot_2dof.m for planar_robot_simulation.slx\n\n');

fprintf(fid, 'q = u_gen(1:4);\n');
fprintf(fid, 'tauc = zeros(2,1);\n');
fprintf(fid, 'q_des = u_gen(5:10);\n');
fprintf(fid, 'm1 = u_gen(11);\n');
fprintf(fid, 'm2 = u_gen(12);\n');
fprintf(fid, 'a1 = u_gen(13);\n');
fprintf(fid, 'a2 = u_gen(14);\n');
fprintf(fid, 'b1 = u_gen(15);\n');
fprintf(fid, 'b2 = u_gen(16);\n');
fprintf(fid, 'g = u_gen(17);\n\n');

fprintf(fid, ['tauc(1) = ', char(ctg1),';\n']);
fprintf(fid, ['tauc(2) = ', char(ctg2),';\n']);
fclose(fid);

%% Gravit with inertia

wn = 100;
zeta = 1;
kp = wn^2;
kv = 2*zeta*wn;

ct_gravit2 = M*(qdd_des + kv*(qd_des - qd) + kp*(q_des - q)) + G;
ctg1 = subs(ct_gravit2(1), {q1, q2, q1d, q2d, tau1, tau2, q1_des, q2_des, q1d_des, q2d_des, q1dd_des, q2dd_des, eps1, eps2}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'q_des(1)', 'q_des(2)', 'q_des(3)', 'q_des(4)', 'q_des(5)', 'q_des(6)', 'eps(1)', 'eps(2)'});
ctg2 = subs(ct_gravit2(2), {q1, q2, q1d, q2d, tau1, tau2, q1_des, q2_des, q1d_des, q2d_des, q1dd_des, q2dd_des, eps1, eps2}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'q_des(1)', 'q_des(2)', 'q_des(3)', 'q_des(4)', 'q_des(5)', 'q_des(6)', 'eps(1)', 'eps(2)'});

%% Controller Simulation file Gravit with inertia

fid = fopen('ct_gravit_inertia_planar_robot_simulink.m', 'w');
fprintf(fid, 'function [tauc] = ct_gravit_inertia_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%% Usage: [tauc] = ct_gravit_inertia_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%%        u_gen: [q, q_des, m1, m2, a1, a2, b1, b2, g]\n');
fprintf(fid, '%% generated by planar_robot_2dof.m for planar_robot_simulation.slx\n\n');

fprintf(fid, 'q = u_gen(1:4);\n');
fprintf(fid, 'tauc = zeros(2,1);\n');
fprintf(fid, 'q_des = u_gen(5:10);\n');
fprintf(fid, 'm1 = u_gen(11);\n');
fprintf(fid, 'm2 = u_gen(12);\n');
fprintf(fid, 'a1 = u_gen(13);\n');
fprintf(fid, 'a2 = u_gen(14);\n');
fprintf(fid, 'b1 = u_gen(15);\n');
fprintf(fid, 'b2 = u_gen(16);\n');
fprintf(fid, 'g = u_gen(17);\n\n');

fprintf(fid, ['tauc(1) = ', char(ctg1),';\n']);
fprintf(fid, ['tauc(2) = ', char(ctg2),';\n']);
fclose(fid);


%% Classical joint control

zeta = 1;
wn = 50;

ki = 1000;
po = ki/wn^2;
kv = 2*zeta*wn + po;
kp = 2*zeta*wn*po + wn^2;

cjc = kv*(qd_des - qd) + kp*(q_des - q) + ki*(epsi);

cjc1 = subs(cjc(1), {q1, q2, q1d, q2d, tau1, tau2, q1_des, q2_des, q1d_des, q2d_des, q1dd_des, q2dd_des, eps1, eps2}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'q_des(1)', 'q_des(2)', 'q_des(3)', 'q_des(4)', 'q_des(5)', 'q_des(6)', 'eps(1)', 'eps(2)'});
cjc2 = subs(cjc(2), {q1, q2, q1d, q2d, tau1, tau2, q1_des, q2_des, q1d_des, q2d_des, q1dd_des, q2dd_des, eps1, eps2}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'q_des(1)', 'q_des(2)', 'q_des(3)', 'q_des(4)', 'q_des(5)', 'q_des(6)', 'eps(1)', 'eps(2)'});

%% Controller Simulation file

fid = fopen('classical_joint_planar_robot_simulink.m', 'w');
fprintf(fid, 'function [tauc] = classical_joint_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%% Usage: [tauc] = classical_joint_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%%        u_gen: [q, eps, q_des, m1, m2, a1, a2, b1, b2, g]\n');
fprintf(fid, '%% generated by planar_robot_2dof.m for planar_robot_simulation.slx\n\n');

fprintf(fid, 'q = u_gen(1:4);\n');
fprintf(fid, 'eps = u_gen(5:6);\n');
fprintf(fid, 'tauc = zeros(2,1);\n');
fprintf(fid, 'q_des = u_gen(7:12);\n');
fprintf(fid, 'm1 = u_gen(13);\n');
fprintf(fid, 'm2 = u_gen(14);\n');
fprintf(fid, 'a1 = u_gen(15);\n');
fprintf(fid, 'a2 = u_gen(16);\n');
fprintf(fid, 'b1 = u_gen(17);\n');
fprintf(fid, 'b2 = u_gen(18);\n');
fprintf(fid, 'g = u_gen(19);\n\n');

fprintf(fid, ['tauc(1) = ', char(cjc1),';\n']);
fprintf(fid, ['tauc(2) = ', char(cjc2),';\n']);
fclose(fid);

%% CT with disturbance estimator

M11 = eval((subs(M(1,1), q2, 0) + subs(M(1,1), q2, pi)))/2;
M22 = eval(M(2,2));
l1 = 100;
l2 = 100;

westi1 = l1/M11;
ratio = 10;
wn1 = 1/ratio *westi1;
zeta = 1;
% wn = 5;
kv1 = 2*zeta*wn1;
kp1 = wn1^2;

westi2 = l2/M22;
wn2 = 1/ratio *westi2;
zeta = 1;
% wn = 5;
kv2 = 2*zeta*wn2;
kp2 = wn2^2;

%% Sliding mode control

lam = diag([25 25]);
KM = diag([10 10]);

s = lam*(q_des-q) + (qd_des - qd);
qd_s = lam * (q_des-q) + qd_des;
qdd_s = lam * (qd_des-qd) + qdd_des;

V2 = [-2*a1*a2*m2*q2d*sin(q2) -a1*a2*m2*q2d*sin(q2); a1*a2*m2*q1d*sin(q2) 0];

M_est = 0.25 * M;
V_est = 0.75 * V2;
G_est = 0.75 * G;

smc = M_est*qdd_s + V_est*qd_s + G_est + KM*sign(5*s);

smc1 = subs(smc(1), {q1, q2, q1d, q2d, tau1, tau2, q1_des, q2_des, q1d_des, q2d_des, q1dd_des, q2dd_des}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'q_des(1)', 'q_des(2)', 'q_des(3)', 'q_des(4)', 'q_des(5)', 'q_des(6)'});
smc2 = subs(smc(2), {q1, q2, q1d, q2d, tau1, tau2, q1_des, q2_des, q1d_des, q2d_des, q1dd_des, q2dd_des}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'q_des(1)', 'q_des(2)', 'q_des(3)', 'q_des(4)', 'q_des(5)', 'q_des(6)'});

%% Controller Simulation file

fid = fopen('smc_planar_robot_simulink.m', 'w');
fprintf(fid, 'function [tauc] = smc_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%% Usage: [tauc] = smc_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%%        u_gen: [q, q_des, m1, m2, a1, a2, b1, b2, g]\n');
fprintf(fid, '%% generated by planar_robot_2dof.m for planar_robot_simulation.slx\n\n');

fprintf(fid, 'q = u_gen(1:4);\n');
fprintf(fid, 'tauc = zeros(2,1);\n');
fprintf(fid, 'q_des = u_gen(5:10);\n');
fprintf(fid, 'm1 = u_gen(11);\n');
fprintf(fid, 'm2 = u_gen(12);\n');
fprintf(fid, 'a1 = u_gen(13);\n');
fprintf(fid, 'a2 = u_gen(14);\n');
fprintf(fid, 'b1 = u_gen(15);\n');
fprintf(fid, 'b2 = u_gen(16);\n');
fprintf(fid, 'g = u_gen(17);\n\n');

fprintf(fid, ['tauc(1) = ', char(smc1),';\n']);
fprintf(fid, ['tauc(2) = ', char(smc2),';\n']);
fclose(fid);

%% Trajectory file SMC

syms t;

T = 2*pi;
k = 1;

qdes1 = k*sin(2*pi*t/T);
qdes2 = k*cos(2*pi*t/T);

qdes1_d = diff(qdes1, t);
qdes2_d = diff(qdes2, t);

qdes1_dd = diff(qdes1_d, t);
qdes2_dd = diff(qdes2_d, t);

fid = fopen('trajectory2_planar_robot_simulink.m', 'w');
fprintf(fid, 'function [qdes] = trajectory2_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%% Usage: [qdes] = trajectory2_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%%        u_gen: [t]\n');
fprintf(fid, '%% generated by planar_robot_2dof.m for planar_robot_simulation.slx\n\n');

fprintf(fid, 't = u_gen(1);\n');
fprintf(fid, 'qdes = zeros(6,1);\n');

fprintf(fid, ['qdes(1) = ', char(qdes1),';\n']);
fprintf(fid, ['qdes(2) = ', char(qdes2),';\n']);
fprintf(fid, ['qdes(3) = ', char(qdes1_d),';\n']);
fprintf(fid, ['qdes(4) = ', char(qdes2_d),';\n']);
fprintf(fid, ['qdes(5) = ', char(qdes1_dd),';\n']);
fprintf(fid, ['qdes(6) = ', char(qdes2_dd),';\n']);
fclose(fid);

%% Adaptive controller 

syms lam1 lam2 m1 m2 gam1 gam2 kv1 kv2

m1r = 0.8;
m2r = 2.3;

lam = [lam1 0; 0 lam2];
gam = [gam1 0; 0 gam2];
Kv = [kv1 0; 0 kv2];

r_ac = lam*(q_des - q) +qd_des - qd;

Y_eq = M*(qdd_des + lam*(qd_des - qd)) + V2_sym * (qd_des + lam*(q_des - q))+G1;

Y = jacobian(Y_eq, [m1 m2])

expression = {'\\mathrm{(\w*)}'; '\\,'; '\<(?![\])(.)(\d+)(d+)'; 'tau'; '(\w*)(?=\d)'; '(?<=\\left\()((?x:\S*?))(?=\\right\))'; '\_{?(\d)}?\_\{d}es'; 'lam'};
replace = {'$1'; ''; '\\$3ot{$1}\_{$2}'; '\\tau'; '$1\_'; '$1'; '\_{D,$1}'; '\\lambda'};

% eq2latexeq(regexprep(latex(Y(1,1)), expression, replace), 'report/equations/Y11.tex');
% eq2latexeq(regexprep(latex(Y(1,2)), expression, replace), 'report/equations/Y12.tex');
% eq2latexeq(regexprep(latex(Y(2,1)), expression, replace), 'report/equations/Y21.tex');
% eq2latexeq(regexprep(latex(Y(2,2)), expression, replace), 'report/equations/Y22.tex');

lam1 = 5;
lam2 = 5;
gam1 = 10;
gam2 = 10;
kv1 = 10;
kv2 = 10;
g = 9.81;

phi_dot = gam*Y.'*r_ac;

phi_d1 = subs(eval(phi_dot(1)), {q1, q2, q1d, q2d, tau1, tau2, q1_des, q2_des, q1d_des, q2d_des, q1dd_des, q2dd_des}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'q_des(1)', 'q_des(2)', 'q_des(3)', 'q_des(4)', 'q_des(5)', 'q_des(6)'});
phi_d2 = subs(eval(phi_dot(2)), {q1, q2, q1d, q2d, tau1, tau2, q1_des, q2_des, q1d_des, q2d_des, q1dd_des, q2dd_des}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'q_des(1)', 'q_des(2)', 'q_des(3)', 'q_des(4)', 'q_des(5)', 'q_des(6)'});

tau_ac = Y_eq + Kv * r_ac;

ac_cl1 = subs(eval(tau_ac(1)), {q1, q2, q1d, q2d, tau1, tau2, q1_des, q2_des, q1d_des, q2d_des, q1dd_des, q2dd_des}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'q_des(1)', 'q_des(2)', 'q_des(3)', 'q_des(4)', 'q_des(5)', 'q_des(6)'});
ac_cl2 = subs(eval(tau_ac(2)), {q1, q2, q1d, q2d, tau1, tau2, q1_des, q2_des, q1d_des, q2d_des, q1dd_des, q2dd_des}, {'q(1)','q(2)','q(3)','q(4)', 'tau(1)', 'tau(2)', 'q_des(1)', 'q_des(2)', 'q_des(3)', 'q_des(4)', 'q_des(5)', 'q_des(6)'});

%% phi dot file

fid = fopen('ac_phi_dot_simulink.m', 'w');
fprintf(fid, 'function [phi_d] = ac_phi_dot_simulink(u_gen)\n');
fprintf(fid, '%% Usage: [phi_d] = ac_phi_dot_simulink(u_gen)\n');
fprintf(fid, '%%        u_gen: [q, q_des]\n');
fprintf(fid, '%% generated by planar_robot_2dof.m for planar_robot_simulation.slx\n\n');

fprintf(fid, 'q = u_gen(1:4);\n');
fprintf(fid, 'phi_d = zeros(2,1);\n');
fprintf(fid, 'q_des = u_gen(5:10);\n');

fprintf(fid, ['phi_d(1) = ', char(phi_d1),';\n']);
fprintf(fid, ['phi_d(2) = ', char(phi_d2),';\n']);
fclose(fid);

%% AC controller file

fid = fopen('ac_controller_simulink.m', 'w');
fprintf(fid, 'function [tauc] = ac_controller_simulink(u_gen)\n');
fprintf(fid, '%% Usage: [tauc] = ac_controller_simulink(u_gen)\n');
fprintf(fid, '%%        u_gen: [q, q_des, m1, m2]\n');
fprintf(fid, '%% generated by planar_robot_2dof.m for planar_robot_simulation.slx\n\n');

fprintf(fid, 'q = u_gen(1:4);\n');
fprintf(fid, 'tauc = zeros(2,1);\n');
fprintf(fid, 'q_des = u_gen(5:10);\n');
fprintf(fid, 'm1 = u_gen(11);\n');
fprintf(fid, 'm2 = u_gen(12);\n');

fprintf(fid, ['tauc(1) = ', char(ac_cl1),';\n']);
fprintf(fid, ['tauc(2) = ', char(ac_cl2),';\n']);
fclose(fid);

%% Trajectory file AC

syms t;

T = 2*pi;
k = 1;

qdes1 = k*sin(2*pi*t/T);
qdes2 = k*sin(2*pi*t/T);

qdes1_d = diff(qdes1, t);
qdes2_d = diff(qdes2, t);

qdes1_dd = diff(qdes1_d, t);
qdes2_dd = diff(qdes2_d, t);

fid = fopen('trajectory3_planar_robot_simulink.m', 'w');
fprintf(fid, 'function [qdes] = trajectory3_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%% Usage: [qdes] = trajectory3_planar_robot_simulink(u_gen)\n');
fprintf(fid, '%%        u_gen: [t]\n');
fprintf(fid, '%% generated by planar_robot_2dof.m for planar_robot_simulation.slx\n\n');

fprintf(fid, 't = u_gen(1);\n');
fprintf(fid, 'qdes = zeros(6,1);\n');

fprintf(fid, ['qdes(1) = ', char(qdes1),';\n']);
fprintf(fid, ['qdes(2) = ', char(qdes2),';\n']);
fprintf(fid, ['qdes(3) = ', char(qdes1_d),';\n']);
fprintf(fid, ['qdes(4) = ', char(qdes2_d),';\n']);
fprintf(fid, ['qdes(5) = ', char(qdes1_dd),';\n']);
fprintf(fid, ['qdes(6) = ', char(qdes2_dd),';\n']);
fclose(fid);

%% 
clear m1 m2 a1 a2 b1 b2 g
m1 = 1;
m2 = 1;
a1 = 1;
a2 = 1;
b1 = 0;
b2 = 0;
g = 9.81;