clear all
close all

L = 9;
L1 = 3;
L2 = 6;
L3 = 27;

x = linspace(0,2*pi,10);
y = sin(x);
z = cos(y);
plot(x,y,z)

xlabel('x')
ylabel('sin(x)')
title('Plot of the Sine Function')