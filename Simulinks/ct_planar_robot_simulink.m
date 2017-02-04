function [tauc] = ct_planar_robot_simulink(u_gen)
q = u_gen(1:4);
tauc = zeros(2,1);
q_des = u_gen(5:10);
m1 = u_gen(11);
m2 = u_gen(12);
a1 = u_gen(13);
a2 = u_gen(14);
g = u_gen(15);

tauc(1) = (a1^2*m1 + a1^2*m2 + a2^2*m2 + 2*a1*a2*m2*cos(q(2)))*(100*q_des(1) - 20*q(3) - 100*q(1) + 20*q_des(3) + q_des(5)) + g*m2*(a2*cos(q(1) + q(2)) + a1*cos(q(1))) + a1*g*m1*cos(q(1)) + a2*m2*(a2 + a1*cos(q(2)))*(100*q_des(2) - 20*q(4) - 100*q(2) + 20*q_des(4) + q_des(6)) - a1*a2*m2*q(4)*sin(q(2))*(2*q(3) + q(4));
tauc(2) = a2^2*m2*(100*q_des(2) - 20*q(4) - 100*q(2) + 20*q_des(4) + q_des(6)) + a2*g*m2*cos(q(1) + q(2)) + a2*m2*(a2 + a1*cos(q(2)))*(100*q_des(1) - 20*q(3) - 100*q(1) + 20*q_des(3) + q_des(5)) + a1*a2*m2*q(3)^2*sin(q(2));
