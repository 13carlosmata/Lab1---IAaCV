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
F = fftwave(10,10,128,2);




%%
%{
close all
clear all
%{
Fhat = zeros(128,128);
p = 5; q = 9;
Fhat(p,q) = 1;
figure
subplot(2,4,1)
imshow(Fhat)
%showgrey(Fhat);
F = ifft2(Fhat);   % inverse discrete FT of Fhat
%}
Fabsmax = max(abs(F(:)));
subplot(2,4,5); showgrey(real(F), 64, -Fabsmax, Fabsmax)
subplot(2,4,6); showgrey(imag(F), 64, -Fabsmax, Fabsmax)
subplot(2,4,7); showgrey(abs(F), 64, -Fabsmax, Fabsmax)
subplot(2,4,8); showgrey(angle(F), 64, -pi, pi)

pz = 128;
fftwave(5,9,pz);
fftwave(9,5,pz);
fftwave(17,9,pz);
fftwave(17,121,pz);
fftwave(5,1,pz);
fftwave(121,1,pz);
function [params] = fftwave(p,q,sz) 
Fhat = zeros (sz);
Fhat(p,q) = 1;
F = ifft2(Fhat);
Fabsmax = max(abs(F(:)));
params = figure;
subplot(3,2,1); showgrey(Fhat);
title(sprintf('Fhat: (p, q) = (%d, %d)', p, q))

if (p <= sz/2)
    pc = p - 1;
else
    pc = p - 1 - sz
end
if (q <= sz/2)
    qc = q - 1;
else
    qc = q - 1 - sz
end

wavelength = 0.0;
amplitude = 0.0;
subplot(3, 2, 2);
%showgrey(Fhat);
showgrey(fftshift(Fhat));
title(sprintf('centered Fhat: (pc, qc) = (%d, %d)', pc, qc))
subplot(3, 2, 3);
showgrey(real(F), 64, -Fabsmax, Fabsmax);
title('real(F)')
subplot(3, 2, 4);
showgrey(imag(F), 64, -Fabsmax, Fabsmax);
title('imag(F)')
subplot(3, 2, 5);
showgrey(abs(F), 64, -Fabsmax, Fabsmax);
title(sprintf('abs(F) (amplitude %f)', amplitude))
subplot(3, 2, 6);
showgrey(angle(F), 64, -pi, pi);
title(sprintf('angle(F) (wavelength %f)', wavelength))
end
%}  




