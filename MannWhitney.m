% MannWhitney.m
%
% Description:
% The `MannWhitney` function conducts Mann-Whitney U tests between two groups, specified by `group1` and `group2`, based on metabolite concentrations provided in the `inputexcel` Excel file. It calculates test results such as p-values and summary statistics (median, minimum, maximum) for each metabolite. The results are then saved in an Excel file specified by `outputexcel`.

% Parameters:
% - `inputexcel`: Excel file containing metabolite concentrations and corresponding class labels for each patient.
% - `outputexcel`: Name of the Excel file where test results will be saved.
% - `group1`: Name of the first group in the comparison (e.g., 'Control').
% - `group2`: Name of the second group in the comparison (e.g., 'Treatment').

% Author:
% Banu Sacli-Bilmez
% Institute of Biomedical Engineering, Bogazici University, Istanbul

function MannWhitney(inputexcel,outputexcel,group1,group2)

[status,sheets] = xlsfinfo(inputexcel);

for n=1:numel(sheets)
    [num,txt,raw] = xlsread(inputexcel, string(sheets(n)));
    num1=num(num(:,end)==0,:);
    size_group1=size(num1,1);
    num2=num(num(:,end)==1,:);
    size_group2=size(num2,1);
    for i=1:size(num,2)-1
        detected_group1(i)=sum(~isnan(num1(:,0+i)),1);
        detected_group2(i)=sum(~isnan(num2(:,0+i)),1);
        median_group1(i)=round(nanmedian(num1(:,0+i)),2);
        median_group2(i)=round(nanmedian(num2(:,0+i)),2);
        min_group1(i)=round(min(num1(:,0+i)),2);
        min_group2(i)=round(min(num2(:,0+i)),2);
        max_group1(i)=round(max(num1(:,0+i)),2);
        max_group2(i)=round(max(num2(:,0+i)),2);
        str_group1{i}=strcat(num2str(median_group1(i)),' [',num2str(min_group1(i)), '-',num2str(max_group1(i)),']');
        str_group2{i}=strcat(num2str(median_group2(i)),' [',num2str(min_group2(i)), '-',num2str(max_group2(i)),']');
        [p(i), h(i)]=ranksum(num1(:,0+i),num2(:,0+i),'Alpha',0.01);
    end

    names=txt(1,1:size(num,2)-1);
    group1_name=strcat(group1, ' (n=', string(size_group1), ')');
    group2_name=strcat(group2, ' (n=', string(size_group2), ')');
    varNames = {'Metabolites',convertStringsToChars(group1_name),'number of detected metabolites in group1', convertStringsToChars(group2_name),'number of detected metabolites in group 2','p-value'};
    T1=table(names',str_group1', detected_group1', str_group2', detected_group2', round(p,3)','VariableNames',varNames);
    writetable(T1,outputexcel,'Sheet', string(sheets(n)));
end

