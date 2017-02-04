%% plotmaker Robot Control

set(0,'defaultLineLineWidth', 1.2)

load q0_down
t = ans(1,1:50:end);
q1 = ans(2,1:50:end);
q2 = ans(3,1:50:end);
q1d = ans(4,1:50:end);
q2d = ans(5,1:50:end);

figure();
subplot(1,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
grid on
% title('$\mathbf{x}_0 = \left( \begin{array}{cccc}\frac{-\pi}{2} & 0 & 0 & 0\end{array}\right)^T$', 'interpreter', 'latex')
subplot(1,2,2);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{q}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{q}_1$','$\dot{q}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
grid on
matlab2tikz('report/pics/planar_robot_model1.tex', 'width', '0.35\textwidth', 'height', '0.4\textwidth');

load q0_up
t = ans(1,1:50:end);
q1 = ans(2,1:50:end);
q2 = ans(3,1:50:end);
q1d = ans(4,1:50:end);
q2d = ans(5,1:50:end);

subplot(1,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
grid on
% title('$\mathbf{x}_0 = \left( \begin{array}{cccc}\frac{\pi}{2} & 0 & 0 & 0\end{array}\right)^T$', 'interpreter', 'latex')

subplot(1,2,2);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{q}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{q}_1$','$\dot{q}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
grid on
matlab2tikz('report/pics/planar_robot_model2.tex', 'width', '0.35\textwidth', 'height', '0.4\textwidth');

load q0_free
t = ans(1,1:50:end);
q1 = ans(2,1:50:end);
q2 = ans(3,1:50:end);
q1d = ans(4,1:50:end);
q2d = ans(5,1:50:end);

subplot(1,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
grid on
% title('$\mathbf{x}_0 = \left( \begin{array}{cccc}0 & 0 & 0 & 0\end{array}\right)^T$', 'interpreter', 'latex')
subplot(1,2,2);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{q}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{q}_1$','$\dot{q}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
grid on

matlab2tikz('report/pics/planar_robot_model3.tex', 'width', '0.35\textwidth', 'height', '0.4\textwidth');

%% CT PD
load ct_pd1
t = ct_pd(1,1:50:end);
q1 = ct_pd(2,1:50:end);
q2 = ct_pd(3,1:50:end);
q1d = ct_pd(4,1:50:end);
q2d = ct_pd(5,1:50:end);
e1 = ct_pd(6,1:50:end);
e2 = ct_pd(7,1:50:end);
tau1 = ct_pd(8,1:50:end);
tau2 = ct_pd(9,1:50:end);

qd_ref1 = (pi*cos(pi*t))/10;
qd_ref2 = -(pi*sin(pi*t))/10;
q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.6 0.4]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/ct_pd1.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

load ct_pd2
t = ct_pd(1,1:50:end);
q1 = ct_pd(2,1:50:end);
q2 = ct_pd(3,1:50:end);
q1d = ct_pd(4,1:50:end);
q2d = ct_pd(5,1:50:end);
e1 = ct_pd(6,1:50:end);
e2 = ct_pd(7,1:50:end);
tau1 = ct_pd(8,1:50:end);
tau2 = ct_pd(9,1:50:end);

q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.14]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southeast');
axis([0 10 -1 0.6]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/ct_pd2.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

load ct_pd3
t = ct_pd(1,1:50:end);
q1 = ct_pd(2,1:50:end);
q2 = ct_pd(3,1:50:end);
q1d = ct_pd(4,1:50:end);
q2d = ct_pd(5,1:50:end);
e1 = ct_pd(6,1:50:end);
e2 = ct_pd(7,1:50:end);
tau1 = ct_pd(8,1:50:end);
tau2 = ct_pd(9,1:50:end);

q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.6 0.4]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/ct_pd3.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

load ct_pd4_dist
t = ct_pd(1,1:50:end);
q1 = ct_pd(2,1:50:end);
q2 = ct_pd(3,1:50:end);
q1d = ct_pd(4,1:50:end);
q2d = ct_pd(5,1:50:end);
e1 = ct_pd(6,1:50:end);
e2 = ct_pd(7,1:50:end);
tau1 = ct_pd(8,1:50:end);
tau2 = ct_pd(9,1:50:end);

q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.6 0.4]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/ct_pd4.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

%% PID

load ct_pid1
t = ct_pid(1,1:50:end);
q1 = ct_pid(2,1:50:end);
q2 = ct_pid(3,1:50:end);
q1d = ct_pid(4,1:50:end);
q2d = ct_pid(5,1:50:end);
e1 = ct_pid(6,1:50:end);
e2 = ct_pid(7,1:50:end);
tau1 = ct_pid(8,1:50:end);
tau2 = ct_pid(9,1:50:end);

q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.6 0.4]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/ct_pid1.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

load ct_pid2
t = ct_pid(1,1:50:end);
q1 = ct_pid(2,1:50:end);
q2 = ct_pid(3,1:50:end);
q1d = ct_pid(4,1:50:end);
q2d = ct_pid(5,1:50:end);
e1 = ct_pid(6,1:50:end);
e2 = ct_pid(7,1:50:end);
tau1 = ct_pid(8,1:50:end);
tau2 = ct_pid(9,1:50:end);

q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.6 0.4]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/ct_pid2.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

%% PD + grav
% wn 100
load pd_grav1
t = pd_grav(1,1:50:end);
q1 = pd_grav(2,1:50:end);
q2 = pd_grav(3,1:50:end);
q1d = pd_grav(4,1:50:end);
q2d = pd_grav(5,1:50:end);
e1 = pd_grav(6,1:50:end);
e2 = pd_grav(7,1:50:end);
tau1 = pd_grav(8,1:50:end);
tau2 = pd_grav(9,1:50:end);

q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.6 0.4]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
axis([0 10 -30 1000]);
grid on

matlab2tikz('report/pics/pd_grav1.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

% wn 10
load pd_grav2
t = pd_grav(1,1:50:end);
q1 = pd_grav(2,1:50:end);
q2 = pd_grav(3,1:50:end);
q1d = pd_grav(4,1:50:end);
q2d = pd_grav(5,1:50:end);
e1 = pd_grav(6,1:50:end);
e2 = pd_grav(7,1:50:end);
tau1 = pd_grav(8,1:50:end);
tau2 = pd_grav(9,1:50:end);

q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.18]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.6 0.6]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/pd_grav2.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

%% Classical PD

load classic_pd1
t = classic_pd(1,1:50:end);
q1 = classic_pd(2,1:50:end);
q2 = classic_pd(3,1:50:end);
q1d = classic_pd(4,1:50:end);
q2d = classic_pd(5,1:50:end);
e1 = classic_pd(6,1:50:end);
e2 = classic_pd(7,1:50:end);
tau1 = classic_pd(8,1:50:end);
tau2 = classic_pd(9,1:50:end);

q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'northwest');
axis([0 10 -0.5 0.15]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.8 0.7]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
% axis([0 10 -30 1000]);
grid on

matlab2tikz('report/pics/classic_pd1.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

load classic_pd2
t = classic_pd(1,1:50:end);
q1 = classic_pd(2,1:50:end);
q2 = classic_pd(3,1:50:end);
q1d = classic_pd(4,1:50:end);
q2d = classic_pd(5,1:50:end);
e1 = classic_pd(6,1:50:end);
e2 = classic_pd(7,1:50:end);
tau1 = classic_pd(8,1:50:end);
tau2 = classic_pd(9,1:50:end);

q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.6 0.4]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
% axis([0 10 -30 1000]);
grid on

matlab2tikz('report/pics/classic_pd2.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

load classic_pd3
t = classic_pd(1,1:50:end);
q1 = classic_pd(2,1:50:end);
q2 = classic_pd(3,1:50:end);
q1d = classic_pd(4,1:50:end);
q2d = classic_pd(5,1:50:end);
e1 = classic_pd(6,1:50:end);
e2 = classic_pd(7,1:50:end);
tau1 = classic_pd(8,1:50:end);
tau2 = classic_pd(9,1:50:end);

q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.6 0.4]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
% axis([0 10 -30 1000]);
grid on

matlab2tikz('report/pics/classic_pd3.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');
%% Classical PID

load classic_pid1
t = classic_pid(1,1:50:end);
q1 = classic_pid(2,1:50:end);
q2 = classic_pid(3,1:50:end);
q1d = classic_pid(4,1:50:end);
q2d = classic_pid(5,1:50:end);
e1 = classic_pid(6,1:50:end);
e2 = classic_pid(7,1:50:end);
tau1 = classic_pid(8,1:50:end);
tau2 = classic_pid(9,1:50:end);

q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.15]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southeast');
axis([0 10 -0.6 0.5]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
% axis([0 10 -30 1000]);
grid on

matlab2tikz('report/pics/classic_pid1.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

load classic_pid2
t = classic_pid(1,1:50:end);
q1 = classic_pid(2,1:50:end);
q2 = classic_pid(3,1:50:end);
q1d = classic_pid(4,1:50:end);
q2d = classic_pid(5,1:50:end);
e1 = classic_pid(6,1:50:end);
e2 = classic_pid(7,1:50:end);
tau1 = classic_pid(8,1:50:end);
tau2 = classic_pid(9,1:50:end);

q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
% axis([0 10 -0.6 0.4]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
% axis([0 10 -30 1000]);
grid on

matlab2tikz('report/pics/classic_pid2.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

load classic_pid3
t = classic_pid(1,1:50:end);
q1 = classic_pid(2,1:50:end);
q2 = classic_pid(3,1:50:end);
q1d = classic_pid(4,1:50:end);
q2d = classic_pid(5,1:50:end);
e1 = classic_pid(6,1:50:end);
e2 = classic_pid(7,1:50:end);
tau1 = classic_pid(8,1:50:end);
tau2 = classic_pid(9,1:50:end);

q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.6 0.5]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'southeast');
% axis([0 10 -30 1000]);
grid on

matlab2tikz('report/pics/classic_pid3.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

%% digital controller

load ct_pd1_digi
t = ct_pd(1,1:50:end);
q1 = ct_pd(2,1:50:end);
q2 = ct_pd(3,1:50:end);
q1d = ct_pd(10,1:50:end);
q2d = ct_pd(11,1:50:end);
e1 = ct_pd(6,1:50:end);
e2 = ct_pd(7,1:50:end);
tau1 = ct_pd(8,1:50:end);
tau2 = ct_pd(9,1:50:end);

% q1d = qd_ref1 - q1d;
% q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.6 0.4]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/ct_pd1_digi.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

load ct_pd2_digi
t = ct_pd(1,1:50:end);
q1 = ct_pd(2,1:50:end);
q2 = ct_pd(3,1:50:end);
q1d = ct_pd(10,1:50:end);
q2d = ct_pd(11,1:50:end);
e1 = ct_pd(6,1:50:end);
e2 = ct_pd(7,1:50:end);
tau1 = ct_pd(8,1:50:end);
tau2 = ct_pd(9,1:50:end);

% q1d = qd_ref1 - q1d;
% q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.6 0.4]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/ct_pd2_digi.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

load ct_pd3_digi
t = ct_pd(1,1:50:end);
q1 = ct_pd(2,1:50:end);
q2 = ct_pd(3,1:50:end);
q1d = ct_pd(10,1:50:end);
q2d = ct_pd(11,1:50:end);
e1 = ct_pd(6,1:50:end);
e2 = ct_pd(7,1:50:end);
tau1 = ct_pd(8,1:50:end);
tau2 = ct_pd(9,1:50:end);

% q1d = qd_ref1 - q1d;
% q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.6 0.4]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
axis([0 10 -0.01 0.1]);
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/ct_pd3_digi.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

load ct_pd4_digi
t = ct_pd(1,1:50:end);
q1 = ct_pd(2,1:50:end);
q2 = ct_pd(3,1:50:end);
q1d = ct_pd(10,1:50:end);
q2d = ct_pd(11,1:50:end);
e1 = ct_pd(6,1:50:end);
e2 = ct_pd(7,1:50:end);
tau1 = ct_pd(8,1:50:end);
tau2 = ct_pd(9,1:50:end);

% qd_ref1 = (pi*cos(pi*t))/10;
% qd_ref2 = -(pi*sin(pi*t))/10;
% q1d = qd_ref1 - q1d;
% q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.6 0.4]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/ct_pd4_digi.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

load ct_pd5_digi
t = ct_pd(1,1:50:end);
q1 = ct_pd(2,1:50:end);
q2 = ct_pd(3,1:50:end);
q1d = ct_pd(10,1:50:end);
q2d = ct_pd(11,1:50:end);
e1 = ct_pd(6,1:50:end);
e2 = ct_pd(7,1:50:end);
tau1 = ct_pd(8,1:50:end);
tau2 = ct_pd(9,1:50:end);

% q1d = qd_ref1 - q1d;
% q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
% axis([0 10 -0.6 0.4]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/ct_pd5_digi.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

%% CT like disturbance estimation
% l1 = l2 = 20, ratio = 2
load ct_dist_esti1
t = ct_de(1,1:50:end);
q1 = ct_de(2,1:50:end);
q2 = ct_de(3,1:50:end);
q1d = ct_de(4,1:50:end);
q2d = ct_de(5,1:50:end);
e1 = ct_de(6,1:50:end);
e2 = ct_de(7,1:50:end);
tau1 = ct_de(8,1:50:end);
tau2 = ct_de(9,1:50:end);

qd_ref1 = (pi*cos(pi*t))/10;
qd_ref2 = -(pi*sin(pi*t))/10;
q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 20 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 20 -0.6 0.4]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
axis([0 20 -0.05 0.15]);
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
axis([0 20 0 100]);
grid on

matlab2tikz('report/pics/ct_dist_esti1.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

% l1 = l2 = 100, ratio = 2
load ct_dist_esti2
t = ct_de(1,1:50:end);
q1 = ct_de(2,1:50:end);
q2 = ct_de(3,1:50:end);
q1d = ct_de(4,1:50:end);
q2d = ct_de(5,1:50:end);
e1 = ct_de(6,1:50:end);
e2 = ct_de(7,1:50:end);
tau1 = ct_de(8,1:50:end);
tau2 = ct_de(9,1:50:end);

qd_ref1 = (pi*cos(pi*t))/10;
qd_ref2 = -(pi*sin(pi*t))/10;
q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 20 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 20 -0.6 0.4]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
axis([0 20 -0.05 0.15]);
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
axis([0 20 -50 200]);
grid on

matlab2tikz('report/pics/ct_dist_esti2.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

% l1 = l2 = 100, ratio = 10
load ct_dist_esti3
t = ct_de(1,1:50:end);
q1 = ct_de(2,1:50:end);
q2 = ct_de(3,1:50:end);
q1d = ct_de(4,1:50:end);
q2d = ct_de(5,1:50:end);
e1 = ct_de(6,1:50:end);
e2 = ct_de(7,1:50:end);
tau1 = ct_de(8,1:50:end);
tau2 = ct_de(9,1:50:end);

qd_ref1 = (pi*cos(pi*t))/10;
qd_ref2 = -(pi*sin(pi*t))/10;
q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 20 -0.2 0.12]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 20 -0.6 0.4]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
axis([0 20 -0.05 0.15]);
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
axis([0 20 0 100]);
grid on

matlab2tikz('report/pics/ct_dist_esti3.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

%% Sliding mode
% lam = 10, km = 20
load smc1
t = smc(1,1:50:end);
q1 = smc(2,1:50:end);
q2 = smc(3,1:50:end);
q1d = smc(4,1:50:end);
q2d = smc(5,1:50:end);
e1 = smc(6,1:50:end);
e2 = smc(7,1:50:end);
tau1 = smc(8,1:50:end);
tau2 = smc(9,1:50:end);

qd_ref1 = cos(t);
qd_ref2 = -sin(t);
q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -1.5 1.1]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -2.5 2]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/smc1.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

% lam = 10, km = 10
load smc2
t = smc(1,1:50:end);
q1 = smc(2,1:50:end);
q2 = smc(3,1:50:end);
q1d = smc(4,1:50:end);
q2d = smc(5,1:50:end);
e1 = smc(6,1:50:end);
e2 = smc(7,1:50:end);
tau1 = smc(8,1:50:end);
tau2 = smc(9,1:50:end);

qd_ref1 = cos(t);
qd_ref2 = -sin(t);
q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -1.5 1.1]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -2.5 2]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/smc2.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

% lam = 25, km = 10
load smc3
t = smc(1,1:50:end);
q1 = smc(2,1:50:end);
q2 = smc(3,1:50:end);
q1d = smc(4,1:50:end);
q2d = smc(5,1:50:end);
e1 = smc(6,1:50:end);
e2 = smc(7,1:50:end);
tau1 = smc(8,1:50:end);
tau2 = smc(9,1:50:end);

qd_ref1 = cos(t);
qd_ref2 = -sin(t);
q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -1.5 1.1]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -2.5 2]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/smc3.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

% lam = 10, km = 20, G = 0
load smc4
t = smc(1,1:50:end);
q1 = smc(2,1:50:end);
q2 = smc(3,1:50:end);
q1d = smc(4,1:50:end);
q2d = smc(5,1:50:end);
e1 = smc(6,1:50:end);
e2 = smc(7,1:50:end);
tau1 = smc(8,1:50:end);
tau2 = smc(9,1:50:end);

qd_ref1 = cos(t);
qd_ref2 = -sin(t);
q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -1.5 1.1]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -2.5 2]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/smc4.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

% lam = 10, km = 30, G = 0
load smc5
t = smc(1,1:50:end);
q1 = smc(2,1:50:end);
q2 = smc(3,1:50:end);
q1d = smc(4,1:50:end);
q2d = smc(5,1:50:end);
e1 = smc(6,1:50:end);
e2 = smc(7,1:50:end);
tau1 = smc(8,1:50:end);
tau2 = smc(9,1:50:end);

qd_ref1 = cos(t);
qd_ref2 = -sin(t);
q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -1.5 1.1]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -2.5 2]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/smc5.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

% lam = 10, km = 20, tanh
load smc6
t = smc(1,1:50:end);
q1 = smc(2,1:50:end);
q2 = smc(3,1:50:end);
q1d = smc(4,1:50:end);
q2d = smc(5,1:50:end);
e1 = smc(6,1:50:end);
e2 = smc(7,1:50:end);
tau1 = smc(8,1:50:end);
tau2 = smc(9,1:50:end);

qd_ref1 = cos(t);
qd_ref2 = -sin(t);
q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -1.5 1.1]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -2.5 2]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/smc6.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

% lam = 10, km = 40, tanh(5s)
load smc7
t = smc(1,1:50:end);
q1 = smc(2,1:50:end);
q2 = smc(3,1:50:end);
q1d = smc(4,1:50:end);
q2d = smc(5,1:50:end);
e1 = smc(6,1:50:end);
e2 = smc(7,1:50:end);
tau1 = smc(8,1:50:end);
tau2 = smc(9,1:50:end);

qd_ref1 = cos(t);
qd_ref2 = -sin(t);
q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,1);
plot(t, q1, t, q2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$q(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$q_1$','$q_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -1.5 1.1]);
grid on
subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{\frac{rad}{s}}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -2.5 2]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/smc7.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');

%% Adaptive control
% lam = 5, gam = 10, kv = 100
load ac_res1
t = ac(1,1:50:end);
q1 = ac(2,1:50:end);
q2 = ac(3,1:50:end);
q1d = ac(4,1:50:end);
q2d = ac(5,1:50:end);
e1 = ac(6,1:50:end);
e2 = ac(7,1:50:end);
tau1 = ac(8,1:50:end);
tau2 = ac(9,1:50:end);
m1s = ac(10,1:50:end);
m2s = ac(11,1:50:end);

qd_ref1 = cos(t);
qd_ref2 = cos(t);
q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -1.5 1.1]);
grid on
subplot(2,2,1);
plot(t, m1s, t, m2s, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$m(t)$ in $\mathrm{kg}$', 'interpreter', 'latex');
legend({'$m_1$','$m_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
% axis([0 10 -2.5 2]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/ac1.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');


% lam = 5, gam = 10, kv = 10
load ac_res2
t = ac(1,1:50:end);
q1 = ac(2,1:50:end);
q2 = ac(3,1:50:end);
q1d = ac(4,1:50:end);
q2d = ac(5,1:50:end);
e1 = ac(6,1:50:end);
e2 = ac(7,1:50:end);
tau1 = ac(8,1:50:end);
tau2 = ac(9,1:50:end);
m1s = ac(10,1:50:end);
m2s = ac(11,1:50:end);

qd_ref1 = cos(t);
qd_ref2 = cos(t);
q1d = qd_ref1 - q1d;
q2d = qd_ref2 - q2d;

subplot(2,2,4);
plot(t, q1d, t, q2d, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\dot{e}(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$\dot{e}_1$','$\dot{e}_2$'}, 'interpreter', 'latex', 'Location', 'southwest');
axis([0 10 -1.5 1.1]);
grid on
subplot(2,2,1);
plot(t, m1s, t, m2s, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$m(t)$ in $\mathrm{kg}$', 'interpreter', 'latex');
legend({'$m_1$','$m_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
% axis([0 10 -2.5 2]);
grid on
subplot(2,2,3);
plot(t, e1, t, e2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$e(t)$ in $\mathrm{rad}$', 'interpreter', 'latex');
legend({'$e_1$','$e_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on
subplot(2,2,2);
plot(t, tau1, t, tau2, 'LineWidth', 1.2);
xlabel('$t$ in $\mathrm{s}$', 'interpreter', 'latex');
ylabel('$\tau(t)$ in $\mathrm{N\,m}$', 'interpreter', 'latex');
legend({'$\tau_1$','$\tau_2$'}, 'interpreter', 'latex', 'Location', 'northeast');
grid on

matlab2tikz('report/pics/ac2.tex', 'width', '0.35\textwidth', 'height', '0.25\textwidth');