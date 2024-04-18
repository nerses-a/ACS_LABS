set(0, 'DefaultFigureWindowStyle', 'docked')

clc;
clear;
close all;

s = tf('s');

W1 = 30/s;
W2 = 5 *s;
W3 = tf(5);

W = (W3 * W2 + W1 * W2) / (1 + W1 + W2)

step(W, 30);
grid on
grid minor
