function reco_RSMPCA(dataset,iEta2)
% Calculate the reconstruction errors of RSMPCA. 
% 2022-6-26 00:34:45

% parameters
tic;
lg_sEta2=-2:0.2:3;  % lg(eta_2)
sEta2=10.^lg_sEta2;  % eta_2
cEta2=sEta2(iEta2);
lg_cEta2=lg_sEta2(iEta2);

% load data
load(sprintf('data/%s_noise',dataset));

% Laplacian matrix
load(sprintf('data/%s_Laplacian.mat',dataset),'L'); 

% RSMPCA
nPV=30; % number of projection vectors
[W,iter]=RSSPCA(x_centered,L,0,cEta2,nPV);
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
save(sprintf('result/reco_RSMPCA_%s_iEta2_%d.mat',dataset,iEta2),'err','iter','time','lg_cEta2');
