function [tauc] = ct_gravit_planar_robot_simulink(u_gen)
%        u_gen: [q, q_des, m1, m2, a1, a2, b1, b2, g]
q = u_gen(1:4);
tauc = zeros(2,1);
q_des = u_gen(5:10);
m1 = u_gen(11);
m2 = u_gen(12);
a1 = u_gen(13);
a2 = u_gen(14);
b1 = u_gen(15);
b2 = u_gen(16);
g = u_gen(17);

tauc(1) = 10000*q_des(1) - 200*q(3) - 10000*q(1) + 200*q_des(3) + (981*cos(q(1) + q(2)))/100 + (981*cos(q(1)))/50;
tauc(2) = 10000*q_des(2) - 200*q(4) - 10000*q(2) + 200*q_des(4) + (981*cos(q(1) + q(2)))/100;
