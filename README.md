# Praktikum
Scripts needed for the Optomotor response practical.

After each experiment iscompleted, copy the data onto the hard drive. Make sure every group has a complete data set. <br/>

## Preparation
Download all these Github scripts onto your laptop.<br/>
Matlab, Miniconda and PyCharm should be installed on your Computers.<br/>
You will need to install 2 environments in miniconda for your analysis scripts (sleep_environment.yml and OMR.yml). More info [here](url). <br/>
### Install an environment from a yml file into anaconda
#### Sleep_env
Open miniconda and navigate to the folder that holds the **sleep_environment.yml** file from Github: ```cd C:\Users\yourfilepath``` <br/>
In minconda: ```conda env create --file environment.yml```. <br/>
To activate the environment ```conda activate sleep_env```.<br/>
Check the installed packages ```conda list```.<br/>
Start Jupyter lab through miniconda ```jupyter lab```. It will open in the Browser. Navigate through the folder structure to your code.<br/>
#### OMR_env
In minconda: ```conda create --file OMR_environment.yml```. <br/>
To activate the environment ```conda activate OMR```.<br/>
Check the installed packages ```conda list```.<br/>


## Sleep Analysis
### MATLAB
Start with the Matlab script to analyse the fish's sleep and waking activity throughout the night and day.<br/>
First, from the Sleep Analysis - Matlab folder, run ["LocmotionAnalyses_Practical.m"](url) in Matlab.<br/>
In the script, go through sections 1-9, one by one. You can run them individually by clicking "run section" in the Editor tab in Matlab.<br/>
You will need to check the followng parameters in the code before running it:<br/>
  Section1: name of the experiment<br/>
  Section2: select the motion from your harddrive.<br/>
  Section3: Select the timestamp file from your harddrive.<br/>
  Section4: Put in the dates of the experiment and define the day and night times. These times should be the same for all groups for better comparison, so check with your peers.<br/>
  Section7: put in the number of animals from your experimental group.<br/>
  Section8: Save all plots on the hard drive.<br/>
  Section9: Save all plots on the hard drive.<br/>
  Before proceeding with the next group, clear the the work space and the command window: ```clear``` and ```clc``` in the Command Window.<br/>

Please share all folders (including all MATLAB-generated csv files) with all other groups, so that you can plot sleep and waking activity against the control group for better comparison.<br/>

### Jupyter Lab
Start miniconda, activate your sleep_environment and start Jupyter Lab.<br/>
Run the code cell by cell and change folders where needed: Below the cell called "Check binning parameters, groups and folder paths here!" <br/>



## Optomotor response (OMR) Anaysis
### PyCharm
#### Exp_info.py
Make sure every group has data from the control group and both treatment groups. Please analyse and compare the control against the treatment groups.
Copy exp_info.py from Github into the folder containing your raw OMR data. Open the file using PyCharm.<br/>
Determine the python interpreter for the project: <br/>
  Click on the four lines in the top left corner --> Settings --> Project 2.OMR_anaysis -->Python Interpreter --> Add interpreter --> Local Interpreter -->conda environment --> Under "Use existing environment": select the OMR environment
Adjust the **date**, **total number of fish** and **trials** in the exp_info file. <br/>
Sort the fish into the correct **treatment groups**. The numbering starts with 0.<br/>
Run the file under right click --> **Run**.If the script ran successfully, the command line will state "Process finished with exit code 0."<br/>

#### Analysis of bout rate, turning angle, response time and correctness.
Copy the **codes** folder into the same directory as your OMR folder. This is essential for the script to find your data.
#### Analysis_dir_extra_incl_lineplot
Open Analysis_bout_rate_turning_angle in PyCharm. Ensure the **OMR environment** is selected. <br/>
In line *519*, under main, paste the folder containing the raw data. Run the script and check the newly created plots in the experiment folder. <br/>
```if __name__ == '__main__': experiment = '2026_04_21_lightpulses'```

Run **Analysis_correctness** and **Analysis_time** in the same manner, by only changing the *experiment* file name. <br\>
Compare your plots with your peers.





  
