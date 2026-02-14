# Jiang_Xia_Code_2026
MATLAB code and Origin data for the paper "Long-range temporal and spatial correlations in discrete kinetic roughening: A large deviation approach"
# MATLAB Simulation Codes and Datasets for Surface Growth Dynamics

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.XXXXXXX.svg)](https://doi.org/10.5281/zenodo.XXXXXXX)

## Overview

This repository contains the source code and datasets associated with the manuscript:  
**"[Long-range temporal and spatial correlations in discrete kinetic roughening: A large deviation approach]"**.

The MATLAB functions provided here are designed to perform the following tasks:
1.  **High-Precision Simulation:** Calculate the height probability distributions using the Large Deviation Algorithm for Ballistic Deposition (BD) and Restricted Solid-on-Solid (RSOS) models, specifically incorporating long-range correlations.
2.  **Finite-Time Analysis:** Predict and select appropriate simulation times (`time`) by analyzing the skewness (S) and kurtosis (K) of the height distribution to address finite-time effects.
3.  **Microstructure Statistics:** Implement a novel statistical method for analyzing surface microstructures.

##  Repository Structure

* `src_matlab/`: Core simulation scripts and functions.
    * `Large_Deviation_Algorithm/`: Codes for calculating height probability distributions.
    * `Pre_Measurement_of_S&K/`: Codes for pre-calculating Skewness and Kurtosis to determine simulation time.
    * `Microstructure_Statistic/`: Codes for microstructure statistical analysis.
* `data_origin/`: Original OriginPro project files (`.oggu`) containing the figures presented in the paper.
* `data_public_csv/`: Universal CSV data files for all figures, accessible for users without OriginPro.

---

##  Simulation Usage Guide

The following examples illustrate the workflow using the **Ballistic Deposition (BD) model with long-range temporal correlations**.

### Step 1: Pre-determination of Simulation Parameters
**Objective:** To determine the correct simulation time window by analyzing finite-time effects on Skewness (S) and Kurtosis (K).

1.  Navigate to the directory: `/src_matlab/Pre_Measurement_of_S&K`.
2.  Run the following command in the MATLAB Command Window:
    ```matlab
    res_H = BDFFGN_TC_SK(256, 6000, 10, 0.1);
    ```
3.  **Output Analysis:** Process the output data to plot **S vs. time** or **K vs. time**. Use these plots to select the appropriate simulation time (`time`) where the system reaches the stationary state regime.

### Step 2: Large Deviation Simulation
**Objective:** To simulate the height probability distribution using the Markov Chain Monte Carlo (MCMC) method.

This module covers ordinary BD/RSOS models and those with long-range temporal/spatial correlations. The main functions follow the naming pattern `MCMC_*_*.m`, corresponding to specific sub-functions `BD*_*.m`.

1.  Navigate to the directory: `/src_matlab/Large_Deviation_Algorithm`.
2.  Run the main simulation function. For example:
    ```matlab
    [res0, HH0] = MCMC_BDHFFGN_TC(256, 2000, 100, 0.1, 1, 0);
    ```
3.  **Outputs**:
    * `res0`: The calculated height probability distribution result under the given bias coefficient.
    * `HH0`: The raw interface height data.

4.  **Post-processing:** Repeat the simulation for different bias coefficients (`THETA1`). Collect the `res*` data series to reconstruct the full large deviation rate function or probability distribution.

---

##  Function Reference

The main simulation functions utilize several key parameters and sub-functions. Below are the detailed descriptions for `MCMC_BDHFFGN_TC` and its dependencies.

### Table 1: Input Parameters 

| Parameter | Symbol | Description |
| :--- | :--- | :--- |
| **L** | $L$ | **Substrate Size**: The lateral size of the simulation system.  |
| **time** | $t$ | **Total Time Steps**: The total duration of the simulation.  |
| **cc** | $N_{ens}$ | **Ensemble Size**: The number of repeated realizations for ensemble averaging.  |
| **th0** | $\theta$ | **Correlation Exponent**: The exponent characterizing the long-range temporal correlation noise. |
| **pr** | $p_r$ | **Modification Ratio**: The proportion of the random matrix modified in each step.  |
| **THETA1** | $\theta_1$ | **Bias Coefficient**: The parameter used to bias the distribution in the importance sampling algorithm.  |

### Table 2: Sub-functions Description 

| Function Name | Role | Description |
| :--- | :--- | :--- |
| `BDHFFGN.m` | Core Solver | Outputs the interface height configuration for a single Markov Chain Monte Carlo (MCMC) step.  |
| `CH_GE.m` | Noise Generator | Generates or updates the random matrix components (noise) during the MCMC stepping process.  |
| `getRes1.m` | Statistical Tool | Converts the raw interface height data (`HH0`) into the height probability distribution statistics.  |

---

##  Requirements

* **MATLAB**: Version R202xx or later.
* **Toolboxes**: (List any specific toolboxes if used, e.g., Statistics and Machine Learning Toolbox).

##  License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
