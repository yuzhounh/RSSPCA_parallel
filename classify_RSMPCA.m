function classify_RSMPCA(dataset,iRep,iEta2)
% Calculate the classification accuracy of RSMPCA. 
% 2022-6-26 00:34:45

% parameters
tic;
lg_sEta2=-2:0.2:6;  % lg(eta_2)
sEta2=10.^lg_sEta2;  % eta_2
cEta2=sEta2(iEta2);
lg_cEta2=lg_sEta2(iEta2);

% Laplacian matrix
load(sprintf('data/%s_Laplacian.mat',dataset),'L');

% load data
load(sprintf('data/%s_r%d.mat',dataset,iRep));

% RSMPCA, a special case of RSSPCA when eta_1=0
nPV=30; % number of projection vectors
[W,iter]=RSSPCA(x_train,L,0,cEta2,nPV);  

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
save(sprintf('result/classify_RSMPCA_%s_iRep_%d_iEta2_%d.mat',dataset,iRep,iEta2),'accuracy','iter','time','lg_cEta2');