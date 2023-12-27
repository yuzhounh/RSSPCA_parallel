% 2022-6-26 00:36:01

clear,clc;

if ~exist('result','dir')
    mkdir('result');
end

% sDataset={'AR','FEI','Feret','GT','ORL','Yale'}';  % image datasets
sDataset={'ORL'};
sRep=1:10;  % repetition

nDataset=length(sDataset);
nRep=length(sRep);

paras={};
count=0;
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    for iRep=1:nRep
        count=count+1;
        paras{count,1}={cDataset,iRep};
    end
end
n=size(paras,1);
fprintf('The number of tasks: %d. \n\n',n);
para_workers;
parfor i=1:n
    para=paras{i,1};
    cDataset=para{1,1};
    iRep=para{1,2};
    classify_PCAL1(cDataset,iRep);
end