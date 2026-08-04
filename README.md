# Long-range-correlations-in-discrete-kinetic-roughening
MATLAB code and Origin data for the paper "Long-range temporal and spatial correlations in discrete kinetic roughening: A large deviation approach"
# MATLAB Simulation Codes and Datasets for Surface Growth Dynamics

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.XXXXXXX.svg)](https://doi.org/10.5281/zenodo.XXXXXXX)

## Overview

This repository contains the source code and datasets associated with the manuscript:  
**"Long-range temporal and spatial correlations in discrete kinetic roughening: A large deviation approach"**.

The MATLAB functions provided here are designed to perform the following tasks:
1.  **High-Precision Simulation:** Calculate the height probability distributions using the Large Deviation Algorithm for Ballistic Deposition (BD) and Restricted Solid-on-Solid (RSOS) models, specifically incorporating long-range correlations.
2.  **Finite-Time Analysis:** Predict and select appropriate simulation times (`time`) by analyzing the skewness ($S$) and kurtosis ($K$) of the height distribution to address finite-time effects.
3.  **Microstructure Statistics:** Implement a novel statistical method for analyzing surface microstructures.

##  Repository Structure

* `src_matlab/`: Core simulation scripts and functions.
    * `Large_Deviation_Algorithm/`: Codes for calculating height probability distributions.
    * `Pre_Measurement_of_S&K/`: Codes for pre-calculating Skewness and Kurtosis to determine simulation time.
    * `Microstructure_Statistic/`: Codes for microstructure statistical analysis.
* `figure_data_origin/`: Original OriginPro project files (`.opju`) containing the figures presented in the paper.The `.opju` files located in this directory contain the high-precision distribution plots, along with the $S$ and $K$ analysis results. **Crucially, the raw datasets are embedded directly within these project files.**

---

##  Simulation Usage Guide

The following examples illustrate the workflow using the **BD model with long-range temporal correlations**.

### Step 1: Pre-determination of Simulation Parameters
**Objective:** To determine the correct simulation time window by minimaling finite-time effects on $S$ and $K$.

1.  Navigate to the directory: `/src_matlab/Pre_Measurement_of_S&K`.
2.  Run the following command in the MATLAB Command Window:
    ```matlab
    res_H = BDFFGN_TC_SK(256, 6000, 10, 0.1);
    ```
3.  **Output Analysis:** Process the output data to plot **$S$ vs. time** or **$K$ vs. time**. Use these plots to select the appropriate simulation time (`time`).

### Step 2: Large Deviation Simulation
**Objective:** To simulate the height probability distribution using the importance sampling method.

This module covers ordinary BD/RSOS models and those with long-range temporal/spatial correlations. The main functions follow the naming pattern `MCMC_*_*.m`, corresponding to specific sub-functions `BD/RSOS*_*.m`.

1.  Navigate to the directory: `/src_matlab/Large_Deviation_Algorithm`.
2.  Run the main simulation function. For example:
    ```matlab
    [res0, HH0] = MCMC_BDHFFGN_TC(256, 2000, 100, 0.1, 1, 0);
    ```
3.  **Outputs**:
    * `res0`: The calculated height probability distribution result under the given bias coefficient.
    * `HH0`: The raw interface height data.

4.  **Post-processing:** Repeat the simulation for different bias coefficients (`THETA1`). Collect the `res*` data series to reconstruct the full large deviation rate function or probability distribution.

### Step 3: Microstructure Statistical Analysis
To analyze the surface morphology statistics of the RSOS model:

1.  Navigate to the directory: `/src_matlab/Microstructure_Statistic`.
2.  Run the following command in the MATLAB Command Window:
    ```matlab
    res0 = sta_micRSOS_strc(RSOS_data);
    ```
    *(Note: Replace `RSOS_data` with your actual variable name).*
3.  **Output**: The result `res0` represents the **probability proportion** of each specific microstructure configuration within the total surface.

---

##  Function Reference

The main simulation functions utilize several key parameters and sub-functions. Below are the detailed descriptions for `MCMC_BDHFFGN_TC` and its dependencies.

### Table 1: Input Parameters 

| Parameter | Description |
| :--- | :--- |
| **L** | **Substrate Size**: The lateral size of the simulation system.  |
| **time** | **Total Time Steps**: The total duration of the simulation.  |
| **cc** | **Ensemble Size**: The number of repeated realizations for ensemble averaging.  |
| **th0** | **Correlation Exponent**: The exponent characterizing the long-range temporal correlation noise. |
| **pr** | **Modification Ratio**: The proportion of the random matrix modified in each step.  |
| **THETA1** | **Bias Coefficient**: The parameter used to bias the distribution in the importance sampling algorithm.  |

### Table 2: Sub-functions Description 

| Function Name | Description |
| :--- | :--- |
| `BDHFFGN.m` | Outputs the interface height configuration for a single Markov Chain Monte Carlo (MCMC) step.  |
| `CH_GE.m` | Generates or updates the random matrix components (noise) during the MCMC stepping process.  |
| `getRes1.m` | Converts the raw interface height data (`HH0`) into the height probability distribution statistics.  |

---

##  Requirements

* **MATLAB**: Version R2024 or later.
* **Toolboxes**: Statistics and Machine Learning Toolbox.

##  License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
