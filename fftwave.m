function F = fftwave(p, q, sz, question)
if (nargin < 2)
    error('Requires at least two input arguments.')
end
if (nargin == 2)
    sz = 128;
end

Fhat = zeros(sz);
Fhat(p, q) = 1;
F = ifft2(Fhat);
Fabsmax = max(abs(F(:)));,

% What is done by these instructions?
if (p <= sz/2)
    pc = p - 1;
else
    pc = p - 1 - sz;
end
if (q <= sz/2)
    qc = q - 1;
else
    qc = q - 1 - sz;
end

wavelength = (2*pi)/(sqrt(p^2+q^2)); % Replace by correct expression
amplitude = 1/sz; % Replace by correct expression
%% Plotting

figure
if question == 1
    subplot(3, 2, 1);
    showgrey(Fhat);
    title(sprintf('Fhat: (p, q) = (%d, %d)', p, q))
    subplot(3, 2, 2);
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
elseif question == 2
    subplot(1,3,1)
    showgrey(Fhat);
    title(sprintf('Fhat: (p, q) = (%d, %d)', p, q))
    subplot(1,3,2)
    showgrey(real(F), 64, -Fabsmax, Fabsmax);
    title('real(F)')
    subplot(1, 3, 3);
    showgrey(imag(F), 64, -Fabsmax, Fabsmax);
    title('imag(F)')
elseif question == 3
    subplot(2,1,1)
    showgrey(Fhat);
    title(sprintf('Fhat: (p, q) = (%d, %d)', p, q))
    subplot(2,1,2);
    showgrey(fftshift(Fhat));
    title(sprintf('centered Fhat: (pc, qc) = (%d, %d)', pc, qc))
end

