function [tauc] = classical_joint_planar_robot_simulink(u_gen)
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

tauc(1) = 100*eps(1) - 625*q(1) - 50*q(3) + 625*q_des(1) + 50*q_des(3);
tauc(2) = 100*eps(2) - 625*q(2) - 50*q(4) + 625*q_des(2) + 50*q_des(4);
