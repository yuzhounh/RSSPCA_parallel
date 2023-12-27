% 2023-12-17 20:54:48

clear,clc;

% calculate the Laplacian matrix
Laplacian_matrix;

% reconstruction
add_noise;
reco_PCA_parallel;
reco_PCAL1_parallel;
reco_RSPCA_parallel;
reco_RSMPCA_parallel;
reco_RSSPCA_parallel;

% classification
split_data;
classify_PCA_parallel;
classify_PCAL1_parallel;
classify_RSPCA_parallel;
classify_RSMPCA_parallel;
classify_RSSPCA_parallel;

% analysis
reco_analysis;
classify_analysis;