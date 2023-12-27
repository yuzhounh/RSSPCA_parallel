% 2022-6-26 00:36:01

clear,clc;

if ~exist('result','dir')
    mkdir('result');
end

% sDataset={'AR','FEI','Feret','GT','ORL','Yale'}';  % image datasets
sDataset={'ORL'};
lg_sEta2=-2:0.2:3;  % lg(eta_2)
sEta2=10.^lg_sEta2;  % eta_2

nDataset=length(sDataset);
nEta2=length(sEta2);

paras={};
count=0;
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    for iEta2=1:nEta2
        count=count+1;
        paras{count,1}={cDataset,iEta2};
    end
end
n=size(paras,1);
fprintf('The number of tasks: %d. \n\n',n);
para_workers;
parfor i=1:n
    para=paras{i,1};
    cDataset=para{1,1};
    iEta2=para{1,2};
    reco_RSMPCA(cDataset,iEta2);
end