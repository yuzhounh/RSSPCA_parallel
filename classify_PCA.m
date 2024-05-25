function classify_PCA(cDataset,iRep)
% Calculate the classification accuracy of PCA. 
% 2022-6-26 00:34:45

% load data
tic;
load(sprintf('data/%s_r%d.mat',cDataset,iRep));

% PCA
nPV=30; % number of projection vectors
W=PCA(x_train,nPV);  

% reserve the projection results
x_train_reserve=W'*x_train;
x_test_reserve=W'*x_test;
t0=toc;

% classification
tic;
accuracy=zeros(nPV,1);
for iPV=1:nPV
    x_train_proj=x_train_reserve(1:iPV,:);
    x_test_proj=x_test_reserve(1:iPV,:);
    
    % nearest neighbor classifier
    dxx=pdist2(x_train_proj',x_test_proj');
    [~,ix]=min(dxx);
    label_predict=label_train(ix);
    
    accuracy(iPV)=mean(label_predict==label_test);
    perct(toc,iPV,nPV,10);
end
t1=toc;
time=(t0+t1)/60;

% save the classification accuracies
save(sprintf('result/classify_PCA_%s_iRep_%d.mat',cDataset,iRep),'accuracy','time');