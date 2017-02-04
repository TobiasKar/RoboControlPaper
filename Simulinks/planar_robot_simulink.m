function [qd] = planar_robot_simulink(u_gen)
q = u_gen(1:4);
qd = zeros(4,1);
tau = u_gen(5:6);
m1 = u_gen(7);
m2 = u_gen(8);
a1 = u_gen(9);
a2 = u_gen(10);
g = u_gen(11);

tau_d = u_gen(12:13);

qd(1) = q(3);
qd(2) = q(4);
qd(3) = (2*a2*tau(1) - 2*a2*tau(2) - 2*a2*tau_d(1) + 2*a2*tau_d(2) - 2*a1*tau(2)*cos(q(2)) + 2*a1*tau_d(2)*cos(q(2)) + a1^2*a2*m2*sin(2*q(2))*q(3)^2 + 2*a1*a2^2*m2*q(3)^2*sin(q(2)) + 2*a1*a2^2*m2*q(4)^2*sin(q(2)) - 2*a1*a2*g*m1*cos(q(1)) - a1*a2*g*m2*cos(q(1)) + a1*a2*g*m2*cos(q(1) + 2*q(2)) + 4*a1*a2^2*m2*q(3)*q(4)*sin(q(2)))/(a1^2*a2*(2*m1 + m2 - m2*cos(2*q(2))));
qd(4) = -(a2^2*m2*tau(1) - a1^2*m2*tau(2) - a1^2*m1*tau(2) - a2^2*m2*tau(2) + a1^2*m1*tau_d(2) + a1^2*m2*tau_d(2) - a2^2*m2*tau_d(1) + a2^2*m2*tau_d(2) + a1*a2^3*m2^2*q(3)^2*sin(q(2)) + a1^3*a2*m2^2*q(3)^2*sin(q(2)) + a1*a2^3*m2^2*q(4)^2*sin(q(2)) - a1*a2^2*g*m2^2*cos(q(1)) + a1^2*a2^2*m2^2*sin(2*q(2))*q(3)^2 + (a1^2*a2^2*m2^2*sin(2*q(2))*q(4)^2)/2 + a1*a2*m2*tau(1)*cos(q(2)) - 2*a1*a2*m2*tau(2)*cos(q(2)) - a1*a2*m2*tau_d(1)*cos(q(2)) + 2*a1*a2*m2*tau_d(2)*cos(q(2)) + a1^3*a2*m1*m2*q(3)^2*sin(q(2)) + 2*a1*a2^3*m2^2*q(3)*q(4)*sin(q(2)) - a1^2*a2*g*m2^2*sin(q(1))*sin(q(2)) - a1*a2^2*g*m1*m2*cos(q(1)) + a1*a2^2*g*m2^2*cos(q(1))*cos(q(2))^2 + a1^2*a2^2*m2^2*sin(2*q(2))*q(3)*q(4) - a1*a2^2*g*m2^2*cos(q(2))*sin(q(1))*sin(q(2)) - a1^2*a2*g*m1*m2*sin(q(1))*sin(q(2)))/(a1^2*a2^2*m2*(m1 + m2 - m2*cos(q(2))^2));
