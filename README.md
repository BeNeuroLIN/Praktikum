# Praktikum
Scripts needed for the Optomotor response practical

After the sleep deprivation experiments are completed, copy the data onto the hard drive.

## Preparation
Download all these Github scripts onto your laptop.<br/>
Matlab, Miniconda and PyCharm should be installed on your Computers.<br/>
You will need to install 2 environments in miniconda for your analysis scripts (xenia_environment.yml and OMR.yml).<br/>
### Install an environment from a yml file into anaconda
#### Sleep_env
In minconda: ```conda create --file sleep_environment.yml```. <br/>
To activate the environment ```conda activate sleep_env```.<br/>
Check the installed packages ```conda list```.<br/>
Start Jupyter lab through miniconda ```jupyter lab```. It will open in the Browser. Navigate through the folder structure to your code.<br/>
#### OMR_env
In minconda: ```conda create --file OMR_environment.yml```. <br/>
To activate the environment ```conda activate OMR```.<br/>
Check the installed packages ```conda list```.<br/>


## Sleep Analysis
### Matlab
Start with the Matlab script to analyse the fish's sleep and waking activity throughout the night and day.<br/>
First, from the Sleep Analysis - Matlab folder, run "LocmotionAnalyses_Practical.m" in Matlab.<br/>
In the script, go through sections 1-9, one by one. You can run them individually by clicking "run section" in the Editor tab in Matlab.<br/>
You will need to check the followng parameters in the code before running it:<br/>
  Section1: name of the experiment<br/>
  Section2: select the motion from your harddrive.<br/>
  Section3: Select the timestamp file from your harddrive.<br/>
  Section4: Put in the dates of the experiment and define the day and night times. These times should be the same for all groups for better comparison, so check with your peers.<br/>
  Section7: put in the number of animals from your experimental group.<br/>
  Section8: Save all plots on the hard drive.<br/>
  Section9: Save all plots on the hard drive.<br/>

  
