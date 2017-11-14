%{
Carlos Mata - Lab1 
Image Analysis and Computer Vision - DD2423
%}
addpath('DD2423_Lab_Files/Functions');
close all
clear all

%% Question 1
p = [5,9,17,17,5,125];
q = [9,5,9,121,1,1];
sz = 128;
for i=1:1:size(p,2)
    F = fftwave(p(i),q(i),sz, 1);
end

%% Question 2
Q_2 = fftwave(10,10,128,2);

%% Question 5
Q_3 = fftwave(127,125,128,3);

%% Question 7

F = [zeros(56,128); ones(16,128); zeros(56,128)];
imshow(F)
G = F';
H = F+2*G;

Fhat = fft2(F);
Ghat = fft2(G);
Hhat = fft2(H);

figure
%subplot(3,2,1);
%showgrey(F);
%title('F')
%subplot(3,2,2);
showgrey((1+abs(Fhat)));
title("FFT(F)");

figure
%subplot(3,2,3);
%showgrey(G);
%title('G')
%subplot(3,2,4);
showgrey(abs(Ghat));
title("FFT(G)");

figure
%subplot(3,2,5);
%showgrey(H);
%title('H')
%subplot(3,2,6);
showgrey(log(1+abs(Hhat)));
title("FFT(H)");

figure
showgrey(log(1+abs(fftshift(Hhat))));

%% Multiplication

% Question 10
close all
F = [zeros(56,128); ones(16,128); zeros(56,128)];
G = F';

figure
subplot(1,4,1);
showgrey(F.*G);
title('F.*G')
subplot(1,4,2);
showfs(fft2(F.*G));
title('fft2(F.*G)')
subplot(1,4,3);
showfs(fft2(F)*fft2(G));
title('fft2(F)*fft2(G)')
subplot(1,4,4);
showfs(fft2(F)*fft2(G)/(128^2));
title('fft2(F)*fft2(G)')

%% Scaling

% Question 11
clc
close all
figure
F = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
    [zeros(128, 48) ones(128, 32) zeros(128, 48)];
FF = fft2(F);

subplot(1,2,1);
showgrey(F);
title('F.*G');
subplot(1,2,2);
showfs(FF);
title('fft2(F)');

%% Rotation

% Question 12
clc
close all
clear all

alpha = 30;
figure;
F = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
    [zeros(128, 48) ones(128, 32) zeros(128, 48)];

angles = [30,45,60,90];
j = 1;
jplot = 1;
figure
for i=angles
    G_x = rot(F,angles(j));
    Ghat_x = fft2(G_x);
    Hhat_x = rot(fftshift(Ghat_x), -angles(j));
   
    subplot(4,3,jplot);
    showgrey(G_x);
    axis on;
    title('G');
    
    subplot(4,3,jplot+1);
    showfs(Ghat_x);
    axis on;
    title('FFT(G)');
    
    subplot(4,3,jplot+2);
    showgrey(log(1+abs(Hhat_x)));
    axis on;
    title(sprintf('Rotated by an angle of: %d', angles(j)));
    
    
    
    j = j + 1;
    jplot = jplot+3;
end




