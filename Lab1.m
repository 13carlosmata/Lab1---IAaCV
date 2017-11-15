%{
Carlos Mata & Kenneth Lau K.W.- Lab1 
Image Analysis and Computer Vision - DD2423
%}

addpath('../DD2423_Lab_Files/Functions');

close all;

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
title('FFT(F)');

figure
%subplot(3,2,3);
%showgrey(G);
%title('G')
%subplot(3,2,4);
showgrey(abs(Ghat));
title('FFT(G)');

figure
%subplot(3,2,5);
%showgrey(H);
%title('H')
%subplot(3,2,6);
showgrey(log(1+abs(Hhat)));
title('FFT(H)');

figure
showgrey(log(1+abs(fftshift(Hhat))));

%% Multiplication

% Question 10
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
close all

alpha = 30;
figure;
F = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
    [zeros(128, 48) ones(128, 32) zeros(128, 48)];

angles = [30,45,60,90];
j = 1;
jplot = 1;
figure;

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
    title(sprintf('Rotation by an angle of: %d', angles(j)));
   
    j = j + 1;
    jplot = jplot+3;
end

%% Phase and Magnitude
addpath('DD2423_Lab_Files/Images-m');
close all
clc
% Question 13
a = 10^-10;

img_1 = phonecalc128;
img_2 = few128;
img_3 = nallo128;

img_1_power = pow2image(img_1,a);
img_2_power = pow2image(img_2,a);
img_3_power = pow2image(img_3,a);

img_1_rs = randphaseimage(img_1);
img_2_rs = randphaseimage(img_2);
img_3_rs = randphaseimage(img_3);

figure;
subplot(3,3,1); showgrey(img_1); title ('phonecalc128');
subplot(3,3,2); showgrey(img_1_power); title ('phonecalc128 + Mag. modification');
subplot(3,3,3); showgrey(img_1_rs); title ('phonecalc128 + Phase modification');

subplot(3,3,4); showgrey(img_2); title ('few128');
subplot(3,3,5); showgrey(img_2_power); title ('few128 + Mag. modification');
subplot(3,3,6); showgrey(img_2_rs); title ('few128 + Phase modification');

subplot(3,3,7); showgrey(img_3); title ('nallo128');
subplot(3,3,8); showgrey(img_3_power); title ('nallo128 + Mag. modification');
subplot(3,3,9); showgrey(img_3_rs); title ('nallo128 + Phase modification');


%% Question 15 & Question 16 Gaussian Convolution implemented via FFT
close all
clc

t = [0.1,0.3,1.0,10.0,100.0,1.0,4.0,16.0,64.0,256.0];
% figure;
% showgrey((deltafcn(128,128)));

figure;
for i=1:1:size(t,2)
    psf = gaussfft(deltafcn(128,128),t(i));
    varPSF = max(max(variance(psf)));
    subplot(2,5,i);
    showfs(fftshift(psf));
    title(['T =',num2str(t(i)),'; v = ',num2str(varPSF)]);
end

%% Question 17 & Question 18 Smoothing 
addpath('../DD2423_Lab_Files/Images-m');
close all;
clc;

% Loading the image
office = office256;
% Adding gaussian noise
add = gaussnoise(office, 16);
% Adding salt and pepper noise
sap = sapnoise(office, 0.1, 255);

% figure();
% showgrey(add);
% figure()
% showgrey(sap);


% Gaussian Smotthing
figure;
t = [0.1,0.3,1.0,10.0,100];
for i=1:1:size(t,2)
    psf = gaussfft(add,t(i));
    subplot(2,5,i);
    showgrey(psf);
    title(['sd^2 =',num2str(t(i))]);
end
for i=1:1:size(t,2)
    psf = gaussfft(sap,t(i));
    subplot(2,5,5+i);
    showgrey(psf);
    title(['sd^2 =',num2str(t(i))]);
end
%}

%{
% Median filtering
figure;
t = [1,3,9,15,27];
for i=1:1:size(t,2)
    psf = medfilt(add,t(i));
    subplot(2,5,i);
    showgrey(psf);
    title(['window size =',num2str(t(i))]);
end
for i=1:1:size(t,2)
    psf = medfilt(sap,t(i));
    subplot(2,5,5+i);
    showgrey(psf);
    title(['window size =',num2str(t(i))]);
end
%}

%{
% Ideal low-pas filtering
figure;
t = [0.01,0.1,1,10,100];
for i=1:1:size(t,2)
    psf = ideal(add,t(i));
    subplot(2,5,i);
    showgrey(psf);
    title(['cut-off freq =',num2str(t(i))]);
end
for i=1:1:size(t,2)
    psf = ideal(sap,t(i));
    subplot(2,5,5+i);
    showgrey(psf);
    title(['cut-off freq =',num2str(t(i))]);
end
%}

%% Question 19 & Question 20 Smoothing and subsampling

addpath('../DD2423_Lab_Files/Images-m');
close all
figure
img = phonecalc256;
smoothimg = img;
N=5;

% for gaussian; t = 0.2 is better
t = 0.2;
suptitle(['Gaussian filter, sd^2 = ',num2str(t)])
for i=1:N
    if i>1    % generate subsampled versions
        img = rawsubsample(img);
        smoothimg = gaussfft(smoothimg,t);
        smoothimg = rawsubsample(smoothimg);
    end
    subplot(2, N, i)
    showgrey(img)
    subplot(2, N, i+N)
    showgrey(smoothimg)
end
%}
%{
% for low pass filter; t=1 is better
t = 1;
suptitle(['Low pass filter, cut-off freq = ',num2str(t)])
for i=1:N
    if i>1    % generate subsampled versions
        img = rawsubsample(img);
        smoothimg = ideal(smoothimg,t);
        smoothimg = rawsubsample(smoothimg);
    end
    subplot(2, N, i)
    showgrey(img)
    subplot(2, N, i+N)
    showgrey(smoothimg)
end
%}

