% add noise on face images
% 2018-4-23 18:33:56

clear,clc,close all;

sDataset={'AR','FEI','Feret','GT','ORL','Yale'}';  % image datasets
nDataset=length(sDataset);
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    load(sprintf('data/%s.mat',cDataset));
    x_clean=x;
    [h,w,nImage]=size(x);

    % add noise
    rng(iDataset);
    ix_noise=randperm(nImage); % random seriers
    n=nImage*20/100; % add noise to 20% of all faces
    nh=randi([10,h],n,1); % noise height >= 10
    nw=randi([10,w],n,1); % noise width >= 10
    for i=1:n
        % noise patch
        noise=255*randi([0,1],[nh(i),nw(i)]); 

        % the noises are locating at a random position
        posh=randi([1,h-nh(i)+1]); % height, position of noise in y axis
        posw=randi([1,w-nw(i)+1]); % width, position of noise in x axis

        % faces correspond to the first 20% of ix_noise are occluded with noise
        x(posh:posh+nh(i)-1, posw:posw+nw(i)-1, ix_noise(i))=noise;
    end
    x_noise=x;

    % display
    figure; montage(reshape(x_clean,h,w,1,nImage),'DisplayRange',[]);
    figure; montage(reshape(x,h,w,1,nImage),'DisplayRange',[]);

    % reshape and demean for reconstruction
    x_noise=reshape(x_noise,[numel(x_noise)/nImage,nImage]);
    x_mean=mean(x_noise,2);
    x_centered=x_noise-repmat(x_mean,1,nImage);

    % save the results
    save(sprintf('data/%s_noise',cDataset),'x_noise','nImage','ix_noise','x_mean','x_centered');
end