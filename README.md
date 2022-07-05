# Mathesonetal2022

This repository contains the code used to analyze the data in A neural circuit for wind-guided olfactory navigation, by Andrew M.M. Matheson, Aaron J. Lanz, Ashley M. Medina, Al M. Licata, Timothy A. Currier, Mubarak H. Syed, and Katherine I. Nagel. 

To run code to analyze the data found at this paper's associated dryad repository place all code found here in your matlab path. 
To execute the creation of figures 1-5 and supplement 1-5 run the functions 'makefigureX_paper.m' where X is the figure and associated supplement you would like to make. This code will generate the figures, run the stats, and save necessary variables to the workspace. To generate the silencing figures in figure 6 run 'gtacr_script.m'. To generate the sparc activation figures in figure 6 and supplementary figure 6 run 'run_orientation_analysis' and 'sparc2_analysis_group.m', respectively. The script 'sparc2_analysis_group.m' should be run with the path positioned in the master folder containing all of the individual sparc fly folders. Model code can be found at it's designated DOI from the paper and can be used to create the simulations in fig7 and S7. 
