function classify_RSPCA(cDataset,iRep,iEta1)
% Calculate the classification accuracy of RSPCA.
% 2022-6-26 00:34:45

% parameters
tic;
lg_sEta1=-6:0.2:6;  % lg(eta_1)
sEta1=10.^lg_sEta1;  % eta_1
cEta1=sEta1(iEta1);
lg_cEta1=lg_sEta1(iEta1);

% Laplacian matrix
load(sprintf('data/%s_Laplacian.mat',cDataset),'L');

% load data
load(sprintf('data/%s_r%d.mat',cDataset,iRep));

% RSPCA, a special case of RSSPCA when eta_2=0
nPV=30; % number of projection vectors
[W,iter]=RSSPCA(x_train,L,cEta1,0,nPV);

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
save(sprintf('result/classify_RSPCA_%s_iRep_%d_iEta1_%d.mat',cDataset,iRep,iEta1),'accuracy','iter','time','lg_cEta1');