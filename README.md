# matlab-mini-project
This project involves the analysis of infrared (IR) spectra from a dataset of 150 pharmaceutical tablet samples. Each tablet contains a mixture of three main chemical components:

API – the active pharmaceutical ingredient

EXC1 and EXC2 – the main excipients

The samples originate from different production batches, and the aim is to verify whether the chemical composition remains consistent across all tablets, ensuring product quality and adherence to manufacturing specifications.

🎯 Objectives

Assess spectral variability across all samples.
Compare the standard deviation of sample spectra to the known reference spectra of API, EXC1, and EXC2.
Identify potential groupings or clusters of samples, which may correspond to different production batches.

🧪 Methodology

Variance-Covariance Matrix: Used to analyze and visualize spectral variability, including plotting the mean spectrum ± standard deviation for comparison with reference spectra.
Principal Component Analysis (PCA): Applied to investigate whether the samples form distinct clusters in the PCA score plot, which could indicate differences in composition due to batch variations.
Loading Plots: Help interpret the chemical meaning of the principal components and explain sample positions in the PCA space in terms of relative component abundance.
