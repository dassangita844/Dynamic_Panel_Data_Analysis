# Dynamic Panel Data Analysis

## Author: Sangita Das

This repository contains Stata code and instructions for performing dynamic panel data analysis, including the estimation of pooled OLS, fixed effects, random effects, and Arellano-Bond models. The analysis focuses on understanding the relationship between variables such as wage (`lwage`), occupation (`occ`), region (`south`), and industry (`ind`), using panel data.

## **Data Source**

The data was provided during the **Workshop on Panel Data Analysis** at **Rabindra Bharati University**, held on **22nd March 2024**.

- **Resource Person**: Prof. Tusher Nandi, Indian Institute of Science Education  

## **Acknowledgment**

Special thanks to **Rabindra Bharati University** for organizing the workshop and to **Prof. Tusher Nandi** for providing the dataset and sharing his invaluable insights on static panel data analysis.

## Table of Contents

1. [Step 1: Load and Explore the Data](#step-1-load-and-explore-the-data)
2. [Step 2: Data Preprocessing](#step-2-data-preprocessing)
3. [Step 3: Preliminary Model Estimation](#step-3-preliminary-model-estimation)
4. [Step 4: Arellano-Bond Dynamic Panel-Data Estimation](#step-4-arellano-bond-dynamic-panel-data-estimation)
5. [Step 5: Advanced Arellano-Bond Models](#step-5-advanced-arellano-bond-models)
6. [Data Source](#data-source)
7. [Acknowledgment](#acknowledgment)
8. [Contact](#contact)

## Step 1: Load and Explore the Data

### Loading the Data
The data is loaded from a `.dta` file:

```stata
use "path/to/dynamic_panel_data.dta", clear
```

### Exploring the Data
We begin by describing the dataset and summarizing it to check for missing values and overall statistics:

```stata
describe
summarize
```

We also check the structure of the panel data:

```stata
xtset
```

## Step 2: Data Preprocessing

### Missing Values
Before proceeding with analysis, it is important to identify missing values in the dataset:

```stata
misstable summarize
```

## Step 3: Preliminary Model Estimation

### Pooled OLS Estimation
A pooled OLS estimation is performed for comparison:

```stata
reg lwage l.lwage occ south ind, robust
```

### Fixed Effects Model
The fixed effects model is estimated using:

```stata
xtreg lwage l.lwage occ south ind, fe robust
```

### Random Effects Model
The random effects model is estimated using:

```stata
xtreg lwage l.lwage occ south ind, re robust
```

## Step 4: Arellano-Bond Dynamic Panel-Data Estimation

### Basic Arellano-Bond Estimation
The basic Arellano-Bond estimation is performed with a lag of 2 for the dependent variable:

```stata
xtabond lwage, lags(2) vce(robust)
```

### Two-step Arellano-Bond Estimation
A two-step Arellano-Bond estimation is used for more accurate standard errors:

```stata
xtabond lwage, lags(2) twostep vce(robust)
```

### Arellano-Bond with Restricted Lag Depth
We restrict the lag depth and perform Arellano-Bond estimation:

```stata
xtabond lwage, lags(2) twostep maxldep(1) vce(robust)
xtabond lwage, lags(2) twostep maxldep(2) vce(robust)
```

## Step 5: Advanced Arellano-Bond Models

### Model with Additional Explanatory Variables
The Arellano-Bond model is extended to include additional explanatory variables:

```stata
xtabond lwage occ south ind, lags(2) twostep maxldep(2) vce(robust)
```

### Model with Predetermined and Endogenous Variables
We define predetermined and endogenous variables, and estimate the Arellano-Bond model:

```stata
xtabond lwage occ south ind, lags(2) twostep maxldep(3) ///
    pre(wks, lag(1, 2)) endogenous(union, lag(0, 2)) vce(robust)
```

### Adding the Arellano-Bond Autocorrelation Test
We add the autocorrelation test for Arellano-Bond estimations:

```stata
xtabond lwage occ south ind, lags(2) twostep maxldep(3) ///
    pre(wks, lag(1, 2)) endogenous(union, lag(0, 2)) vce(robust) artest(3)
```

## **Contact**

For queries or feedback, please contact:  
**Sangita Das**  
Email: [dassangita844@gmail.com](mailto:dassangita844@gmail.com)

**Note**: This repository and analysis are intended for educational purposes only.
