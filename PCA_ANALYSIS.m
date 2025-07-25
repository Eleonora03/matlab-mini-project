function [L, S, sigma, Sigma, chi] = PCA_ANALYSIS(T)
    % PCA_ANALYSIS Performs Principal Component Analysis on input matrix T.
    %   Returns loadings (L), scores (S), eigenvalues (sigma),
    %   covariance matrix (Sigma), and centered data (chi).

    % Center the input matrix by subtracting the mean of each column
    chi = T - mean(T);

    % Get the number of observations (rows)
    No = size(chi, 1);

    % Compute the covariance matrix of the centered data
    Sigma = cov(chi);

    % Calculate eigenvectors (L) and eigenvalues (sigma) of the covariance matrix
    [L, sigma] = eig(Sigma);

    % Sort eigenvalues in descending order and rearrange eigenvectors accordingly
    [sigma, idx] = sort(diag(sigma), 'descend');
    L = L(:, idx);

    % Calculate the principal component scores
    S = chi * L / sqrt(No - 1);

    %