# MRS_statistical_analysis
This repository contains a suite of scripts aimed at automating LCModel analysis of MRS data acquired with a Siemens MR scanner. It also includes tools for reading, preparing, and conducting statistical tests on LCModel results, streamlining the entire process.


## Components:

## MRS_Analysis_WaterScaling.py
This script automates MRS data analysis using LCModel. It reads MRS data and its corresponding water reference from multiple patients stored in separate directories, converts the data to LCModel-compatible format, performs the analysis, and saves the results in a folder named 'Output' within each patient's directory.

### ReadingLCModelMetaboliteQuantification.m
This script gathers LCModel output from each patient folder and lists it in an Excel file. To start, please define a PatientListandTags.mat file containing Patient IDs to be included. The script extracts the quantification outputs from each patient folder and produces an Excel sheet where each row will represent a patient with a corresponding patient ID.

### CRLBthresholding_PRESS.m
This script reads the Excel file outputted by ReadingLCModelMetaboliteQuantification.m and applies CRLB thresholding with ratios of 20%, 30%, 40%, 50%, and 100%. It outputs Excel sheets for each threshold ratio.

### MannWhitney.m
This script conducts Mann-Whitney U tests between two groups, specified by `group1` and `group2`, based on metabolite concentrations provided in the `inputexcel` Excel file. It calculates test results such as p-values and summary statistics (median, minimum, maximum) for each metabolite. The results are then saved in an Excel file specified by `outputexcel`.

### Kruskal_Wallis_Tukey_IDH_TERT.m
This script performs Kruskal-Wallis tests followed by Tukey-Kramer post-hoc analysis between different groups (IDH-only, TERTp-only, Double mutant, Double negative) based on metabolite concentrations provided in the `inputexcel` Excel file. It calculates test results such as p-values and confidence intervals for pairwise group comparisons. The results are then saved in separate sheets of an Excel file.

If you have any questions, suggestions, or feedback, feel free to contact us via banusacli@gmail.com
