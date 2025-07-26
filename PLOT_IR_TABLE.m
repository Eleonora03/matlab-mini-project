function  PLOT_IR_TABLE(wavenumber, T, chi, L, S, sigma , R)
% PLOT_IR_TABLE plots multiple graphs for spectral and PCA analysis.
% Inputs:
%   wavenumber - vector of wavelength values
%   T          - absorbance data matrix
%   chi        - centered data matrix
%   L          - loadings from PCA
%   S          - scores from PCA
%   sigma      - principal variances
%   R          - reference spectra

No = height(T); % Number of samples

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     NIR Spectra Plots      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig = figure('Units', 'pixels', 'Position', [200 200 1000 400]);
subplot(1, 2, 1);
hold on;
for i = 1:No
    plot(wavenumber, T(i , :), 'LineWidth',1.5);
end
xlabel('Wavelength (nm)');
ylabel('Absorbance');
ylim ([0 3.4]);
title('UV-Vis Spectra');
text(0.05, 0.95, 'a)', 'Units', 'normalized', 'FontSize', 14, 'FontWeight', 'bold');

subplot(1, 2, 2);
hold on
for i = 1:height(T)
    plot(wavenumber, chi(i, :), 'LineWidth', 1.5);
end
hold off
xlabel('Wavelength (nm)');
ylabel('Absorbance');
title('Centered Spectra');
text(0.05, 0.95, 'b)', 'Units', 'normalized', 'FontSize', 14, 'FontWeight', 'bold');
saveas(fig, 'UV_VIS_spectra.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Covariance Matrix Plots    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig = figure('Units', 'pixels', 'Position', [200 200 1200 400]);
subplot(1, 2, 1);
hold on;
imagesc(wavenumber, wavenumber, cov(T));
contour(wavenumber, wavenumber, cov(T), 16, 'k-');
xlabel('Wavelength (nm)');
ylabel('Wavelength (nm)');
xlim([min(wavenumber) max(wavenumber)]);
ylim([min(wavenumber) max(wavenumber)]);
clim([-0.05 0.05]);
colorbar();
title('Covariance Matrix');

subplot(1, 2, 2);
hold on;
plot(wavenumber, mean(T), 'LineWidth', 1.5, 'Color', [0.9 0.2 0.2]);
plot(wavenumber, mean(T) + std(T), 'LineWidth', 1.5, 'Color', [0.9 0.7 0.7]);
plot(wavenumber, mean(T) - std(T), 'LineWidth', 1.5, 'Color', [0.9 0.7 0.9]);
for c = 1:width(R)
    plot(wavenumber, 0.5 * R(:, c) - 2, 'LineWidth', 1.5)
end
legend('Mean Spectrum', 'Mean + Std Dev', 'Mean - Std Dev', 'API Reference', 'ECX1 Reference', 'EXC2 Reference');
xlabel('Wavelength (nm)');
ylabel('Absorbance');
ylim([-2 3]);
title('Mean Spectrum with Reference Spectra');
saveas(fig, 'Mean Spectrum with Reference Spectra and Covariance Matrix.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Principal Components Plots %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig = figure('Units', 'pixels', 'Position', [200 200 1200 400]);
subplot(1, 2, 1)
plot(1:10, sigma(1:10), 'LineWidth', 1.5, 'Marker','o', 'Color', [0.2 0.2 0.8])
xlabel('Principal Component Index');
ylabel('Explained Variance');
title('Principal Component Scree Plot');
ylim([-0.5 23])

subplot(1, 2, 2)
hold on
for c = 1:width(R)
    plot(wavenumber, 0.35 * R(:, c), 'LineWidth', 1.5)
end
plot(wavenumber, 0.5 * L(:, 1) - 1, 'LineWidth', 1.5, 'Color', 'r')
plot(wavenumber, 5 * L(:, 2) - 1, 'LineWidth', 1.5)
legend('API Reference', 'ECX1 Reference', 'EXC2 Reference', 'PC1 Loading', 'PC2 Loading')
xlabel('Wavelength (nm)');
ylabel('Absorbance');
ylim([-2 2])
title('Reference Spectra and Principal Component Loadings');
saveas(fig, 'Reference Spectra and Principal Component Loadings and Principal Component Scree Plot.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Scores Scatter Plot     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig = figure();
Sprime = S * diag(1.0 ./ sqrt(sigma));
plot(Sprime(:, 1), Sprime(:, 2), 'ro');
xlabel('PC1 Score');
ylabel('PC2 Score');
title('Scores Scatter Plot');
saveas(fig, 'Scores Scatter Plot.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Mean and PC1/PC2 Plots   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('Units', 'pixels', 'Position', [200 200 1200 400]);

% Plot mean spectrum and PC1 variations
subplot(1, 2, 1);
hold on
plot(wavenumber, mean(T), 'LineWidth', 2)
plot(wavenumber, mean(T) + 2.0 * L(:, 1)', 'Color', [0.9 0.7 0.7], 'LineWidth', 2)
plot(wavenumber, mean(T) - 2.0 * L(:, 1)', 'Color', [0.7 0.7 0.9], 'LineWidth', 2)
xlabel('Wavelength (nm)');
ylabel('Absorbance');
ylim([0 2]);
title('Mean Spectrum with PC1 Variation');
legend("Mean Spectrum", "Mean + 2×PC1", "Mean - 2×PC1");

% Plot mean spectrum and PC2 variations
subplot(1, 2, 2);
hold on
plot(wavenumber, mean(T), 'LineWidth', 2)
plot(wavenumber, mean(T) + 2.0 * L(:, 2)', 'Color', [0.9 0.7 0.7], 'LineWidth', 2)
plot(wavenumber, mean(T) - 2.0 * L(:, 2)', 'Color', [0.7 0.7 0.9], 'LineWidth', 2)
xlabel('Wavelength (nm)');
ylabel('Absorbance');
ylim([0 2]);
title('Mean Spectrum with PC2 Variation');
legend("Mean Spectrum", "Mean + 2×PC2", "Mean - 2×PC2");
saveas(fig, 'Mean Spectrum with PC1 and PC2 Variation.png');
end