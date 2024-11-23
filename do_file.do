********** Dynamic Panel Data Analysis **********
*Sangita Das*

***********************************
* Step 1: Load and Explore the Data
***********************************

* create the log file to save the operation and result
log using "C:\Users\Sangita Das\Desktop\Panel_data\Dynamic_panel\log_file.smcl"

* Load the data
use "C:\Users\Sangita Das\Desktop\Panel_data\Panel_data_RBU\2_dynamc_panel_data.dta", clear

* Display basic information about the dataset
describe

* Summarize the dataset to check for missing values and overall statistics
summarize

* Check the structure of the panel data
xtset

***********************************
* Step 2: Data Preprocessing
***********************************

* Identify missing values and report them
misstable summarize

***********************************
* Step 3: Preliminary Model Estimation
***********************************

* Pooled OLS estimation for comparison
reg lwage l.lwage occ south ind, robust

* Fixed effects model
xtreg lwage l.lwage occ south ind, fe robust

* Random effects model
xtreg lwage l.lwage occ south ind, re robust

***********************************
* Step 4: Arellano-Bond Dynamic Panel-Data Estimation
***********************************

* Basic Arellano-Bond estimation
xtabond lwage, lags(2) vce(robust)

* Two-step Arellano-Bond estimation
xtabond lwage, lags(2) twostep vce(robust)

* Arellano-Bond with restricted lag depth
xtabond lwage, lags(2) twostep maxldep(1) vce(robust)
xtabond lwage, lags(2) twostep maxldep(2) vce(robust)

***********************************
* Step 5: Advanced Arellano-Bond Models
***********************************

* Model including additional explanatory variables
xtabond lwage occ south ind, lags(2) twostep maxldep(2) vce(robust)

* Model with predetermined and endogenous variables
xtabond lwage occ south ind, lags(2) twostep maxldep(3) ///
    pre(wks, lag(1, 2)) endogenous(union, lag(0, 2)) vce(robust)

* Adding the Arellano-Bond autocorrelation test
xtabond lwage occ south ind, lags(2) twostep maxldep(3) ///
    pre(wks, lag(1, 2)) endogenous(union, lag(0, 2)) vce(robust) artest(3)

