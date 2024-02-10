% Kruskal_Wallis_Tukey_IDH_TERT.m
% Description:
% The `Kruskal_Wallis_Tukey_IDH_TERT` function performs Kruskal-Wallis tests followed by Tukey-Kramer post-hoc analysis between different groups (IDH-only, TERTp-only, Double mutant, Double negative) based on metabolite concentrations provided in the `inputexcel` Excel file. It calculates test results such as p-values and confidence intervals for pairwise group comparisons. The results are then saved in separate sheets of an Excel file.

% Parameters:
% - `inputexcel`: Excel file containing metabolite concentrations and corresponding class labels for each patient.

% Author:
% Banu Sacli-Bilmez
% Institute of Biomedical Engineering, Bogazici University, Istanbul

function Kruskal_Wallis_Tukey_IDH_TERT(inputexcel, outputexcel)

[status,sheets] = xlsfinfo(inputexcel);

for n=1:numel(sheets)
    [num,txt,raw] = xlsread(inputexcel, string(sheets(n)));
    

a=0;
for i=1:size(num,1)
    if isnan(num(i,2))
        a=[a i];
    end
end
a(1)=[]; num(a,:)=[];

    for i=1:size(num,1)
        if num(i,1)==1 && num(i,2)==1
            group{i}='Double mutant';
        elseif num(i,1)==1 && num(i,2)==0
            group{i}='IDH-only';
        elseif num(i,1)==0 && num(i,2)==1
            group{i}='TERTp-only';
        elseif num(i,1)==0 && num(i,2)==0
            group{i}='Double negative';
        end
    end

    variables={'Group1','Group2','CI(lower)','Difference between group means','CI(upper)','p-value',''};
    emptyCol = cell(6,1);
    Total=array2table(zeros(7,1));
    for i=3:size(num,2)
        [p(i-2),tbl,stats] = kruskalwallis(num(:,i)',group,'off');
        c(:,:,i-2) = multcompare(stats,'alpha',0.05,'CType','tukey-kramer','estimate','kruskalwallis');
        T=table([variables; [num2cell(round(c(:,:,i-2),3)) emptyCol]],'VariableNames',txt(1,i));
        Total=[Total T];
    end
    Total(:,1)=[];
    writetable(Total, outputexcel,'Sheet', string(sheets(n)),'Range','A1');

end
end
