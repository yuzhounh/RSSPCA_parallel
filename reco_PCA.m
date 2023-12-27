function reco_PCA(dataset)
% Calculate the reconstruction errors of PCA. 
% 2022-6-26 00:34:45

% load data
tic;
load(sprintf('data/%s_noise',dataset));

% PCA
nPV=30; % number of projection vectors
W=PCA(x_centered,nPV);
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
save(sprintf('result/reco_PCA_%s.mat',dataset),'err','time');
