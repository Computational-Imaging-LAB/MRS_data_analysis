# Automated MRS data analysis using LCModel

# This Python script automates MRS data analysis using LCModel. 
# It reads MRS data and its corresponding water reference from multiple patients stored in separate directories, 
# converts the data to LCModel-compatible format, performs the analysis, 
# and saves the results in a folder named 'Output' within each patient's directory.

# Authors:
# Sevim Cengiz and Banu Sacli-Bilmez
# Institute of Biomedical Engineering, Bogazici University, Istanbul


import os
import os.path
from os import listdir
from os import makedirs
from os import path
from os import remove
from os import system
import sys
import subprocess

#Control file
control_template_file = open('control', 'r')
control_file = control_template_file.read()
control_template_file.close()
control_file_name = 'run.control'

#Patients Inputs

current_dir = path.dirname(path.realpath(__file__))
patient_path_dir=os.path.join(current_dir, 'Patients')
patient_dir_names = listdir(patient_path_dir)

for dir_name in patient_dir_names:
    dir_path = os.path.join(patient_path_dir, dir_name )
    input_dir = os.path.join(dir_path, 'Input')
    fid_dir = os.path.join(input_dir, 'FID')
    h2o_dir = os.path.join(input_dir, 'h2o')
    output_dir = os.path.join(dir_path, 'Output')
    if not path.exists(output_dir):
        makedirs(output_dir)

    source_file_names = listdir(fid_dir)
#    h2o_file = listdir(h2o_dir)
    h2o_file_names = listdir(h2o_dir)
    for source_file in source_file_names: # source_file == '1.IMA'
        for h2o_file in h2o_file_names:
            source_file_name = source_file[:-4] # source_file_name == '1'
            h2o_file_name = h2o_file[:-4]
            source_file_path = os.path.join(fid_dir, source_file)
            h2o_file_path = os.path.join(h2o_dir, h2o_file)
        #current_h2o_dir = h2o_dir#os.path.join(h2o_dir, 'h2o')
            current_output_dir = output_dir
            current_met_dir = os.path.join(current_output_dir, 'met')
            current_h2o_dir = os.path.join(current_output_dir, 'h2o')

            if not path.exists(current_met_dir):
                makedirs(current_met_dir)

            if not path.exists(current_h2o_dir):
                makedirs(current_h2o_dir)
                
            updated_control_file = control_file
            updated_control_file = updated_control_file.replace("__TITLE__", source_file_name)
            updated_control_file = updated_control_file.replace("__SOURCE__", source_file_path)
            updated_control_file = updated_control_file.replace("__SAVE_DIRECTORY__", os.path.join(current_output_dir, 'saved'))
            updated_control_file = updated_control_file.replace("__TABLE_FILE__", os.path.join(output_dir, source_file_name))
            updated_control_file = updated_control_file.replace("__PS_FILE__", os.path.join(output_dir, source_file_name))
            updated_control_file = updated_control_file.replace("__CSV_FILE__", os.path.join(output_dir, source_file_name))
            updated_control_file = updated_control_file.replace("__COORD_FILE__", os.path.join(output_dir, source_file_name))
            updated_control_file = updated_control_file.replace("__PRINT_FILE__", os.path.join(output_dir, source_file_name))
            updated_control_file = updated_control_file.replace("__RAW_FILE__", os.path.join(current_met_dir, 'RAW'))
            updated_control_file = updated_control_file.replace("__h2o_FILE__", os.path.join(current_h2o_dir, 'RAW'))


            current_control_file = open(control_file_name, 'w')
            current_control_file.write(updated_control_file)
            current_control_file.close()

            raw_conversion_command = "~/.lcmodel/siemens/bin2raw \"" + source_file_path + "\" \"" + current_output_dir + "/\" \"met\""
            system(raw_conversion_command)

            h2o_conversion_command = "~/.lcmodel/siemens/bin2raw \"" + h2o_file_path + "\" \"" + current_output_dir + "/\" \"h2o\""
            system(h2o_conversion_command)

            analyse_command = "~/.lcmodel/bin/lcmodel < " + control_file_name
            system(analyse_command)
        
remove(control_file_name)


