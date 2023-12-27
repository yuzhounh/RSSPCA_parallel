% 2022-6-26 00:36:01

clear,clc;

if ~exist('result','dir')
    mkdir('result');
end

% sDataset={'AR','FEI','Feret','GT','ORL','Yale'}';  % image datasets
sDataset={'ORL'};
sRep=1:10;  % repetition
lg_sEta2=-2:0.2:6;  % lg(eta_2)
sEta2=10.^lg_sEta2;  % eta_2

nDataset=length(sDataset);
nRep=length(sRep);
nEta2=length(sEta2);

paras={};
count=0;
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    for iRep=1:nRep
        for iEta2=1:nEta2
            count=count+1;
            paras{count,1}={cDataset,iRep,iEta2};
        end
    end
end
n=size(paras,1);
fprintf('The number of tasks: %d. \n\n',n);
para_workers;
parfor i=1:n
    para=paras{i,1};
    cDataset=para{1,1};
    iRep=para{1,2};
    iEta2=para{1,3};
    classify_RSMPCA(cDataset,iRep,iEta2);
end