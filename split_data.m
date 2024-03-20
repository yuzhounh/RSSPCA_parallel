% load data and split it into training and testing set
% 2018-4-23 18:33:56

clear,clc;

sDataset={'AR','FEI','Feret','GT','ORL','Yale'}';  % image datasets
nDataset=length(sDataset);
nRep=10; % repeat for k times

for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};

    load(sprintf('data/%s.mat',cDataset));
    [image_height,image_width,n_image]=size(x);
    dim=image_height*image_width;
    x=reshape(x,[dim,n_image]); % 2D to 1D

    % randomly choose a subset for trainning
    for iRep=1:nRep
        rng(iDataset+iRep);
        ix_train=zeros(n_image,1);
        tmp=randperm(n_image);
        ix_train(tmp(1:ceil(n_image*2/3)))=1; % 2/3 images for training
        ix_test=1-ix_train;

        ix_train=find(ix_train);
        ix_test=find(ix_test);

        n_train=length(ix_train);
        n_test=length(ix_test);

        x_train=x(:,ix_train);
        x_test=x(:,ix_test);

        label_train=label(ix_train);
        label_test=label(ix_test);

        % subtract the mean for classification 
        x_mean=mean(x_train,2);
        x_train=x_train-repmat(x_mean,[1,n_train]);
        x_test=x_test-repmat(x_mean,[1,n_test]);

        % save the results
        save(sprintf('data/%s_r%d.mat',cDataset,iRep),'x_train','x_test','label_train','label_test');
    end
end
