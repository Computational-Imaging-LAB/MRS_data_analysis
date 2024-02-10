% Gather LCModel output from each patient folder and list on a excel file
% Define PatientListandTags which contains Patients ID's
% Code will go to folder using Patient ID and extract quantification output
% Each row will represent a patient with corresponding ID

% Authors:
% Ayhan Gursan and Banu Sacli-Bilmez
% Institute of Biomedical Engineering, Bogazici University, Istanbul

clear; clc;
cd('C:\Users\ASUS\Desktop\Workspace\Glioma\LCModel_Outputs'); % Change directory here
mainfolder=cd;
patientlist=dir;
excelfile='C:\Users\ASUS\Desktop\Workspace\Glioma\Glioma_30ms_LCModel_Outputs.xlsx'; %Change output excel file here
for i=3:numel(patientlist(:,1))
    IDfolder=strcat(mainfolder,'\',string(patientlist(i).name),'\Output');
    cd(IDfolder);
    listcsv=dir('*.csv');
    readout=csvread(listcsv(1).name,1,2);
    PatientID=(patientlist(i).name);
    csvdatarow=strcat('B',num2str(i));
    patientIDrow=strcat('A',num2str(i));
    xlswrite(excelfile, cellstr(PatientID),1,patientIDrow);
    xlswrite(excelfile,readout,1,csvdatarow);    
    cd(mainfolder);
end

IDfolder=strcat(mainfolder,'\',string(patientlist(i).name),'\Output');
cd(IDfolder);
readout_met=readtable(listcsv(1).name,'ReadVariableNames', true);
met_names=readout_met.Properties.VariableNames(1,3:end);
xlswrite(excelfile,{'PatientID'},1,'A1');
xlswrite(excelfile,met_names,1,'B1');
