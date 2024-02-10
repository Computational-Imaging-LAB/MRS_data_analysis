% CRLBthresholding_PRESS.m
% Parameters:
% inputexcel: excel file that consists patient numbers, metabolite
%             concentration, SD and relative concentration values, and 
%             corresponding classes
% a, the column number of the first metabolite, e.g.Ala in our case
% class, the column number of the classes, e.g.IDH in our case
	
% Authors:
% Banu Sacli-Bilmez & Ayhan Gursan
% Institute of Biomedical Engineering, Bogazici University, Istanbul

function [] = CRLBthresholding_PRESS(inputexcel,a,class) 
% Metabolite selection in short echo time PRESS regarding varying CRLB thresholds
[SVS.excel.num,SVS.excel.txt,SVS.excel.raw] = xlsread(inputexcel);
SVS.metablist=cellstr(SVS.excel.txt(1,a:3:end)); %Each metabolite that used in analysis
listnum=numel(SVS.excel.num(:,1));
metabnum=numel(SVS.excel.txt(1,a:3:end));
SVS.metablist=cellstr(SVS.excel.txt(1,a:3:end));%Each metabolite that used in analysis
SVS.Conc=zeros(listnum,metabnum);
SVS.ConcSD=zeros(listnum,metabnum);
SVS.relConc=zeros(listnum,metabnum);

%For metabolite concentration, SD and relative concentration values a
%matrix has been filled with data from excel sheet.

for i=1:listnum
    SVS.Conc(i,:)=SVS.excel.num(i,a:3:end); %Concentration values in arbitrary units
    SVS.ConcSD(i,:)=SVS.excel.num(i,a+1:3:end); %CRLB values for the estimation of metabolites
    SVS.relConc(i,:)=SVS.excel.num(i,a+2:3:end); %Concentration ratios relative to tCr estimation
end
clear listnum;

% Zero the metabolites with SD 999%
SVS.SD999=find(SVS.ConcSD==999);   %Modify SD threshold from here.
SVS.Conc(SVS.SD999)=0;      %Assign 0 to SD 999% on Concentration values
SVS.relConc(SVS.SD999)=0;   %Assign 0 to SD 999% on relative concentration value

% Define matrices to be filled with NaN
SVS.Conc20nan=SVS.Conc;     SVS.relConc20nan=SVS.relConc;
SVS.Conc30nan=SVS.Conc;     SVS.relConc30nan=SVS.relConc;
SVS.Conc40nan=SVS.Conc;     SVS.relConc40nan=SVS.relConc;
SVS.Conc50nan=SVS.Conc;     SVS.relConc50nan=SVS.relConc;
SVS.Conc100nan=SVS.Conc;    SVS.relConc100nan=SVS.relConc;

% Define matrices to be filled with zero
SVS.Conc20zero=SVS.Conc;    SVS.relConc20zero=SVS.relConc;
SVS.Conc30zero=SVS.Conc;    SVS.relConc30zero=SVS.relConc;
SVS.Conc40zero=SVS.Conc;    SVS.relConc40zero=SVS.relConc;
SVS.Conc50zero=SVS.Conc;    SVS.relConc50zero=SVS.relConc;
SVS.Conc100zero=SVS.Conc;   SVS.relConc100zero=SVS.relConc;

% Threshold of 20%
Overthreshold20=SVS.ConcSD>20;   %Modify SD threshold from here.
%NaN filling%
SVS.Conc20nan(Overthreshold20)=NaN;      %Assign NaN to Concentration value
SVS.relConc20nan(Overthreshold20)=NaN;   %Assign NaN to relative concentration value
SVS.Conc20nan(SVS.SD999)=0;      %Assign 0 to SD 999% on Concentration values
SVS.relConc20nan(SVS.SD999)=0;   %Assign 0 to SD 999% on relative concentration value
%Zero filling%
SVS.Conc20zero(Overthreshold20)=0;      %Assign zero to Concentration value
SVS.relConc20zero(Overthreshold20)=0;   %Assign zero to relative concentration value

% Threshold of 30%
Overthreshold30=SVS.ConcSD>30;   %Modify SD threshold from here.
%NaN filling%
SVS.Conc30nan(Overthreshold30)=NaN;      %Assign NaN to Concentration value
SVS.relConc30nan(Overthreshold30)=NaN;   %Assign NaN to relative concentration value
SVS.Conc30nan(SVS.SD999)=0;      %Assign 0 to SD 999% on Concentration values
SVS.relConc30nan(SVS.SD999)=0;   %Assign 0 to SD 999% on relative concentration value
%Zero filling%
SVS.Conc30zero(Overthreshold30)=0;      %Assign zero to Concentration value
SVS.relConc30zero(Overthreshold30)=0;   %Assign zero to relative concentration value

% Threshold of 40%
Overthreshold40=SVS.ConcSD>40;   %Modify SD threshold from here.
%NaN filling%
SVS.Conc40nan(Overthreshold40)=NaN;      %Assign NaN to Concentration value
SVS.relConc40nan(Overthreshold40)=NaN;   %Assign NaN to relative concentration value
SVS.Conc40nan(SVS.SD999)=0;      %Assign 0 to SD 999% on Concentration values
SVS.relConc40nan(SVS.SD999)=0;   %Assign 0 to SD 999% on relative concentration value
%Zero filling%
SVS.Conc40zero(Overthreshold40)=0;      %Assign zero to Concentration value
SVS.relConc40zero(Overthreshold40)=0;   %Assign zero to relative concentration value

% Threshold of 50%
Overthreshold50=SVS.ConcSD>50;   %Modify SD threshold from here.
%NaN filling%
SVS.Conc50nan(Overthreshold50)=NaN;      %Assign NaN to Concentration value
SVS.relConc50nan(Overthreshold50)=NaN;   %Assign NaN to relative concentration value
SVS.Conc50nan(SVS.SD999)=0;      %Assign 0 to SD 999% on Concentration values
SVS.relConc50nan(SVS.SD999)=0;   %Assign 0 to SD 999% on relative concentration value
%Zero filling%
SVS.Conc50zero(Overthreshold50)=0;      %Assign zero to Concentration value
SVS.relConc50zero(Overthreshold50)=0;   %Assign zero to relative concentration value

% Threshold of 100%
Overthreshold100=SVS.ConcSD>100;   %Modify SD threshold from here.
%NaN filling%
SVS.Conc100nan(Overthreshold100)=NaN;      %Assign NaN to Concentration value
SVS.relConc100nan(Overthreshold100)=NaN;   %Assign NaN to relative concentration value
SVS.Conc100nan(SVS.SD999)=0;      %Assign 0 to SD 999% on Concentration values
SVS.relConc100nan(SVS.SD999)=0;   %Assign 0 to SD 999% on relative concentration value
%Zero filling%
SVS.Conc100zero(Overthreshold100)=0;      %Assign zero to Concentration value
SVS.relConc100zero(Overthreshold100)=0;   %Assign zero to relative concentration value

clear Overthreshold20 Overthreshold30 Overthreshold40 Overthreshold50 Overthreshold100;
%% Selected metabolites as features
fprintf('Metabolites that been selected as features(SVS_30ms):')
SVS.FeatureMetabs=[1:metabnum]; %assign number of selected metabolite indices 
disp(SVS.metablist(SVS.FeatureMetabs))

%% Construction of matrixes for Machine Learning algorithm
%Concentration ratios over creatine
SVS.ML.input20nan=SVS.relConc20nan(:,SVS.FeatureMetabs); SVS.ML.input20nan(:,end+1)=SVS.excel.num(:,class);
SVS.ML.input20zero=SVS.relConc20zero(:,SVS.FeatureMetabs); SVS.ML.input20zero(:,end+1)=SVS.excel.num(:,class);

SVS.ML.input30nan=SVS.relConc30nan(:,SVS.FeatureMetabs); SVS.ML.input30nan(:,end+1)=SVS.excel.num(:,class);
SVS.ML.input30zero=SVS.relConc30zero(:,SVS.FeatureMetabs); SVS.ML.input30zero(:,end+1)=SVS.excel.num(:,class);

SVS.ML.input40nan=SVS.relConc40nan(:,SVS.FeatureMetabs); SVS.ML.input40nan(:,end+1)=SVS.excel.num(:,class);
SVS.ML.input40zero=SVS.relConc40zero(:,SVS.FeatureMetabs); SVS.ML.input40zero(:,end+1)=SVS.excel.num(:,class);

SVS.ML.input50nan=SVS.relConc50nan(:,SVS.FeatureMetabs); SVS.ML.input50nan(:,end+1)=SVS.excel.num(:,class);
SVS.ML.input50zero=SVS.relConc50zero(:,SVS.FeatureMetabs); SVS.ML.input50zero(:,end+1)=SVS.excel.num(:,class);

SVS.ML.input100nan=SVS.relConc100nan(:,SVS.FeatureMetabs); SVS.ML.input100nan(:,end+1)=SVS.excel.num(:,class);
SVS.ML.input100zero=SVS.relConc100zero(:,SVS.FeatureMetabs); SVS.ML.input100zero(:,end+1)=SVS.excel.num(:,class);

% Arbitrary Units
SVS.ML.input20nanAU=SVS.Conc20nan(:,SVS.FeatureMetabs); SVS.ML.input20nanAU(:,end+1)=SVS.excel.num(:,class);
SVS.ML.input20zeroAU=SVS.Conc20zero(:,SVS.FeatureMetabs); SVS.ML.input20zeroAU(:,end+1)=SVS.excel.num(:,class);
SVS.ML.input30nanAU=SVS.Conc30nan(:,SVS.FeatureMetabs); SVS.ML.input30nanAU(:,end+1)=SVS.excel.num(:,class);
SVS.ML.input30zeroAU=SVS.Conc30zero(:,SVS.FeatureMetabs); SVS.ML.input30zeroAU(:,end+1)=SVS.excel.num(:,class);
SVS.ML.input40nanAU=SVS.Conc40nan(:,SVS.FeatureMetabs); SVS.ML.input40nanAU(:,end+1)=SVS.excel.num(:,class);
SVS.ML.input40zeroAU=SVS.Conc40zero(:,SVS.FeatureMetabs); SVS.ML.input40zeroAU(:,end+1)=SVS.excel.num(:,class);
SVS.ML.input50nanAU=SVS.Conc50nan(:,SVS.FeatureMetabs); SVS.ML.input50nanAU(:,end+1)=SVS.excel.num(:,class);
SVS.ML.input50zeroAU=SVS.Conc50zero(:,SVS.FeatureMetabs); SVS.ML.input50zeroAU(:,end+1)=SVS.excel.num(:,class);
SVS.ML.input100nanAU=SVS.Conc100nan(:,SVS.FeatureMetabs); SVS.ML.input100nanAU(:,end+1)=SVS.excel.num(:,class);
SVS.ML.input100zeroAU=SVS.Conc100zero(:,SVS.FeatureMetabs); SVS.ML.input100zeroAU(:,end+1)=SVS.excel.num(:,class);


%% Construct excel sheet from ML matrixes
% cd(pipelinefilepath)
warning ('off','all');
SVS.ML.NaN_excelname='PRESS_NaN.xlsx';
SVS.ML.zero_excelname='PRESS_zero.xlsx';
labels=SVS.metablist(SVS.FeatureMetabs);labels(end+1)={'group'};
% Excel file for features assigned as NaN
xlswrite(SVS.ML.NaN_excelname,labels,'SVS_20','A1');xlswrite(SVS.ML.NaN_excelname,SVS.ML.input20nan,'SVS_20','A2');
xlswrite(SVS.ML.NaN_excelname,labels,'SVS_30','A1');xlswrite(SVS.ML.NaN_excelname,SVS.ML.input30nan,'SVS_30','A2');
xlswrite(SVS.ML.NaN_excelname,labels,'SVS_40','A1');xlswrite(SVS.ML.NaN_excelname,SVS.ML.input40nan,'SVS_40','A2');
xlswrite(SVS.ML.NaN_excelname,labels,'SVS_50','A1');xlswrite(SVS.ML.NaN_excelname,SVS.ML.input50nan,'SVS_50','A2');
xlswrite(SVS.ML.NaN_excelname,labels,'SVS_100','A1');xlswrite(SVS.ML.NaN_excelname,SVS.ML.input100nan,'SVS_100','A2');
% Excel file for features assigned as zero
xlswrite(SVS.ML.zero_excelname,labels,'SVS_20','A1');xlswrite(SVS.ML.zero_excelname,SVS.ML.input20zero,'SVS_20','A2');
xlswrite(SVS.ML.zero_excelname,labels,'SVS_30','A1');xlswrite(SVS.ML.zero_excelname,SVS.ML.input30zero,'SVS_30','A2');
xlswrite(SVS.ML.zero_excelname,labels,'SVS_40','A1');xlswrite(SVS.ML.zero_excelname,SVS.ML.input40zero,'SVS_40','A2');
xlswrite(SVS.ML.zero_excelname,labels,'SVS_50','A1');xlswrite(SVS.ML.zero_excelname,SVS.ML.input50zero,'SVS_50','A2');
xlswrite(SVS.ML.zero_excelname,labels,'SVS_100','A1');xlswrite(SVS.ML.zero_excelname,SVS.ML.input100zero,'SVS_100','A2');

SVS.ML.NaN_excelname_AU='PRESS_NaN_AU.xlsx';
SVS.ML.zero_excelname_AU='PRESS_zero_AU.xlsx';

% Excel file for AU features assigned as NaN
xlswrite(SVS.ML.NaN_excelname_AU,labels,'SVS_20_AU','A1');xlswrite(SVS.ML.NaN_excelname_AU,SVS.ML.input20nanAU,'SVS_20_AU','A2');
xlswrite(SVS.ML.NaN_excelname_AU,labels,'SVS_30_AU','A1');xlswrite(SVS.ML.NaN_excelname_AU,SVS.ML.input30nanAU,'SVS_30_AU','A2');
xlswrite(SVS.ML.NaN_excelname_AU,labels,'SVS_40_AU','A1');xlswrite(SVS.ML.NaN_excelname_AU,SVS.ML.input40nanAU,'SVS_40_AU','A2');
xlswrite(SVS.ML.NaN_excelname_AU,labels,'SVS_50_AU','A1');xlswrite(SVS.ML.NaN_excelname_AU,SVS.ML.input50nanAU,'SVS_50_AU','A2');
xlswrite(SVS.ML.NaN_excelname_AU,labels,'SVS_100_AU','A1');xlswrite(SVS.ML.NaN_excelname_AU,SVS.ML.input100nanAU,'SVS_100_AU','A2');

% Excel file for AU features assigned as zero
xlswrite(SVS.ML.zero_excelname_AU,labels,'SVS_20_AU','A1');xlswrite(SVS.ML.zero_excelname_AU,SVS.ML.input20zeroAU,'SVS_20_AU','A2');
xlswrite(SVS.ML.zero_excelname_AU,labels,'SVS_30_AU','A1');xlswrite(SVS.ML.zero_excelname_AU,SVS.ML.input30zeroAU,'SVS_30_AU','A2');
xlswrite(SVS.ML.zero_excelname_AU,labels,'SVS_40_AU','A1');xlswrite(SVS.ML.zero_excelname_AU,SVS.ML.input40zeroAU,'SVS_40_AU','A2');
xlswrite(SVS.ML.zero_excelname_AU,labels,'SVS_50_AU','A1');xlswrite(SVS.ML.zero_excelname_AU,SVS.ML.input50zeroAU,'SVS_50_AU','A2');
xlswrite(SVS.ML.zero_excelname_AU,labels,'SVS_100_AU','A1');xlswrite(SVS.ML.zero_excelname_AU,SVS.ML.input100zeroAU,'SVS_100_AU','A2');
warning ('on','all');

% Return back to main folder
% cd(pipelinefilepath)
