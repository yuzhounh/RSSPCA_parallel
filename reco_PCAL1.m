function reco_PCAL1(dataset)
% Calculate the reconstruction errors of PCA-L1. 
% 2022-6-26 00:34:45

% Laplacian matrix
tic;
load(sprintf('data/%s_Laplacian.mat',dataset),'L');

% load data
load(sprintf('data/%s_noise',dataset));

% PCA-L1, a speical case of RSSPCA when eta_1=0 and eta_2=0
nPV=30; % number of projection vectors
[W,iter]=RSSPCA(x_centered,L,0,0,nPV);  
t0=toc;

% calculate the reconstruction error
tic;
err=zeros(nPV,1);
for iPV=1:nPV
    w=W(:,1:iPV);
    
    % reconstructed images
    x_reco=zeros(size(x_noise));
    for iImage=1:nImage
        x_reco(:,iImage)=w*w'*x_centered(:,iImage)+x_mean;
    end
    temp=x_noise-x_reco;
    
    % residual errors
    rsd=0;
    for iImage=nImage/5+1:nImage
        rsd=rsd+norm(temp(:,ix_noise(iImage)));
    end
    err(iPV)=rsd/(nImage*4/5);
    
    perct(toc,iPV,nPV,10);
end
t1=toc;
time=(t0+t1)/60;

% save the reconstruction errors
save(sprintf('result/reco_PCAL1_%s.mat',dataset),'err','iter','time');
