
# T-04 Group 1 FPGA-Based Pseudo-Random Number Generator (PRNG)

This repository contains the source code and documentation for our Term 6 project in the Digital Systems Lab (30.110) at SUTD, developed in April 2024. The project focuses on implementing a pseudo-random number generator using the logistic map, realized in Verilog HDL on a CMOD-A7 FPGA board. The PRNG utilizes chaotic systems to generate numbers that follow a Gaussian distribution, thanks to the application of the Central Limit Theorem (CLT) and an Exponentially Weighted Moving Average (EWMA) approach.

## Project Overview

The logistic map, known for its chaotic yet deterministic nature, forms the core of our PRNG. This project demonstrates the practical application of chaotic systems in generating Gaussian-distributed pseudo-random numbers and integrates various FPGA modules for enhanced functionality.

### Key Features

- **Logistic Map Implementation**: Utilizes the logistic map for generating pseudo-random sequences.
- **Gaussian Distribution**: Achieves Gaussian distribution
