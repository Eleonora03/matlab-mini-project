clc; clear; close all;

% Load sample and reference spectra from CSV files
T = readtable('spectra_samples.csv');                % Sample spectra
R = readtable('spectra_referencec.csv');             % Reference spectra

% Clean and process the tables, extract wavenumber
[T, wavenumber, R] = CLEAN_TABLE(T, R);

% Perform Principal Component Analysis on the sample spectra
[L, S, sigma, chi] = PCA_ANALYSIS(T);

% Plot the results: spectra, PCA, and reference comparisons
PLOT_IR_TABLE(wavenumber, T, chi, L, S, sigma , R); 

