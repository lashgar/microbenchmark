This tool provides a microbenchmarking suit to undestand the design of CUDA-capable GPGPUs in handling outstanding memory requests. Read [1] to read the methodology.

# INSTALLING 

steps to run the benchmarks:

1) Modify the Makefile and set CUDAHOME to the CUDA root. (notice: $CUDAHOME/bin/nvcc should be valid)

2) Compile OpenACC library (This library is outsourced from IPMACC project):

   `$ make openacc`

3) Modify run_single_config.sh file and set destination CUDA GPU: `GPUARCH=-arch=sm_20`

4) optional: modify the run_all_config.sh file and specify the range of threads, loads per threads, and memory patterns.

5) Run run_all_config.sh

    `$ bash ./run_all_config.sh`

   raw results will be stored in the log/data*.spc. In each file, each row reports the times measured for certains number of threads. There three independent runs are reported. Eeach run reports the numbers measured by up to 16 concurrent warps.

7) post-process the data and retrieve latency/variance correponding to each thread by running auxil/calcvar.py:

    `$ python calcvar.py -f log/data_2merged_2loads.spc`

8) processed output will be stored at the same location with the suffix of .csv. Plot the data with your favorite visualizing tool, e.g. gnuplot.

# NOTICE 

since run_single_config.sh appends the output to the file, it is recommended to clear the last run log before every run (using `make clean` command)

# ABOUT 

Author: Ahmad Lashgar

Affiliation: University of Victoria

Contact: lashgar@uvic.ca

# References 

[1] Ahmad Lashgar, Ebad Salehi, and Amirali Baniasadi. **Understanding Outstanding Memory Request Handling Resources in GPGPUs**. To be appeared in The Sixth International Symposium on Highly Efficient Accelerators and Reconfigurable Technologies (HEART). Boston MA, USA, June 1-2, 2015.
