% 2022-6-26 00:36:01

clear,clc;

if ~exist('result','dir')
    mkdir('result');
end

% sDataset={'AR','FEI','Feret','GT','ORL','Yale'}';  % image datasets
sDataset={'ORL'};
lg_sEta1=-5:0.2:3;  % lg(eta_1)
sEta1=10.^lg_sEta1;  % eta_1

nDataset=length(sDataset);
nEta1=length(sEta1);

paras={};
count=0;
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    for iEta1=1:nEta1
        count=count+1;
        paras{count,1}={cDataset,iEta1};
    end
end
n=size(paras,1);
fprintf('The number of tasks: %d. \n\n',n);
para_workers;
parfor i=1:n
    para=paras{i,1};
    cDataset=para{1,1};
    iEta1=para{1,2};
    reco_RSPCA(cDataset,iEta1);
end