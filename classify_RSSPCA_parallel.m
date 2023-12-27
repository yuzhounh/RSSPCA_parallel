% 2022-6-26 00:36:01

clear,clc;

if ~exist('result','dir')
    mkdir('result');
end

% sDataset={'AR','FEI','Feret','GT','ORL','Yale'}';  % image datasets
sDataset={'ORL'};
sRep=1:10;  % repetition
lg_sEta1=-3:0.2:1;  % lg(eta_1)
lg_sEta2=-1:0.2:3;  % lg(eta_2)
sEta1=10.^lg_sEta1;  % eta_1
sEta2=10.^lg_sEta2;  % eta_2

nDataset=length(sDataset);
nRep=length(sRep);
nEta1=length(sEta1);
nEta2=length(sEta2);

paras={};
count=0;
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    for iRep=1:nRep
        for iEta1=1:nEta1
            for iEta2=1:nEta2
                count=count+1;
                paras{count,1}={cDataset,iRep,iEta1,iEta2};
            end
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
    iEta1=para{1,3};
    iEta2=para{1,4};
    classify_RSSPCA(cDataset,iRep,iEta1,iEta2);
end