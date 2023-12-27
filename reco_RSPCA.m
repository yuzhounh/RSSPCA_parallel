function reco_RSPCA(dataset,iEta1)
% Calculate the reconstruction errors of RSPCA. 
% 2022-6-26 00:34:45

% parameters
tic;
lg_sEta1=-5:0.2:3;  % lg(eta_1)
sEta1=10.^lg_sEta1;  % eta_1
cEta1=sEta1(iEta1);
lg_cEta1=lg_sEta1(iEta1);

% load data
load(sprintf('data/%s_noise',dataset));

% Laplacian matrix
load(sprintf('data/%s_Laplacian.mat',dataset),'L'); 

% RSPCA
nPV=30; % number of projection vectors
[W,iter]=RSSPCA(x_centered,L,cEta1,0,nPV);
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
save(sprintf('result/reco_RSPCA_%s_iEta1_%d.mat',dataset,iEta1),'err','iter','time','lg_cEta1');
