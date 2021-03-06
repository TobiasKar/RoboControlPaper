function [qdes] = trajectory_planar_robot_simulink(u_gen)
t = u_gen(1);
qdes = zeros(6,1);
qdes(1) = sin(t*pi)/10;
qdes(2) = cos(t*pi)/10;
qdes(3) = (pi*cos(t*pi))/10;
qdes(4) = -(pi*sin(t*pi))/10;
qdes(5) = -(pi^2*sin(t*pi))/10;
qdes(6) = -(pi^2*cos(t*pi))/10;
