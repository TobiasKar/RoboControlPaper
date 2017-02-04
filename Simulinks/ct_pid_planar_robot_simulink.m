function [tauc] = ct_pid_planar_robot_simulink(u_gen)
%        u_gen: [q, eps, q_des, m1, m2, a1, a2, b1, b2, g]
q = u_gen(1:4);
eps = u_gen(5:6);
tauc = zeros(2,1);
q_des = u_gen(7:12);
m1 = u_gen(13);
m2 = u_gen(14);
a1 = u_gen(15);
a2 = u_gen(16);
g = u_gen(17);

tauc(1) = (a1^2*m1 + a1^2*m2 + a2^2*m2 + 2*a1*a2*m2*cos(q(2)))*(500*eps(1) - 189*q(1) - (381*q(3))/16 + 189*q_des(1) + (381*q_des(3))/16 + q_des(5)) + g*m2*(a2*cos(q(1) + q(2)) + a1*cos(q(1))) + a2*m2*(a2 + a1*cos(q(2)))*(500*eps(2) - 189*q(2) - (381*q(4))/16 + 189*q_des(2) + (381*q_des(4))/16 + q_des(6)) + a1*g*m1*cos(q(1)) - a1*a2*m2*q(4)*sin(q(2))*(2*q(3) + q(4));
tauc(2) = a2^2*m2*(500*eps(2) - 189*q(2) - (381*q(4))/16 + 189*q_des(2) + (381*q_des(4))/16 + q_des(6)) + a2*g*m2*cos(q(1) + q(2)) + a2*m2*(a2 + a1*cos(q(2)))*(500*eps(1) - 189*q(1) - (381*q(3))/16 + 189*q_des(1) + (381*q_des(3))/16 + q_des(5)) + a1*a2*m2*q(3)^2*sin(q(2));
