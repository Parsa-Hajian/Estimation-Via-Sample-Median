# Estimation-Via-Sample-Median
This project explores the estimation of the location parameter (\(m\)) of a Cauchy distribution using the sample median. It leverages a Shiny app to simulate, visualize, and analyze the behavior of sample medians across different sample sizes and numbers of simulations.

---

## Features

1. **Simulation of Sample Medians**:
   - Draws random samples of size \(n\) from a Cauchy distribution with a specified location parameter (\(m\)).
   - Computes the sample median for \(M\) simulations.

2. **Interactive Visualization**:
   - Generates histograms showing the empirical distribution of sample medians.
   - Overlays a Gaussian curve to explore the shape of the distribution.

3. **Statistical Insights**:
   - Observes how the distribution of sample medians behaves as the sample size (\(n\)) increases.
   - Displays the mean and standard deviation of the simulated medians.

---

## Usage Instructions

### Prerequisites

Ensure you have the following installed:
- **R** (version 4.0 or higher)
- **Shiny** package  

Install the Shiny package if needed:
```R
install.packages("shiny")
