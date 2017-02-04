%%
%clear all;
clc;
pfad = 'C:\Users\sevimeda\Desktop\Master\Robot Control\Robot_Control\Robot_Control\Robot_control_Eda';

load('initial_conditions1');
figure('Color','white')
plot(ans(1,:),[ans(2,:);ans(3,:)],'LineWidth',2)
title('Initial Conditions [-pi/2 0]');
xlabel('time [s]');
ylabel('q(t) [rad]');
legend('q1','q2');
grid on;
saveas(gcf,'initpos1.jpg');
%%
%clear all;
clc;

load('initial_conditions2');
figure('Color','white')
plot(ans(1,:),[ans(2,:);ans(3,:)],'LineWidth',2)
title('Initial Conditions [pi/2 0]');
xlabel('time [s]');
ylabel('q(t) [rad]');
legend('q1','q2');
grid on;
saveas(gcf,'initpos2.jpg');
%%
