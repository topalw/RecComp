#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=100G
#SBATCH --job-name=maketable
#SBATCH --account jgoudet_barn_owl
#SBATCH -e RUNFILES/%x_%A_stderr
#SBATCH -o RUNFILES/%x_%A_stdout

#dcsrsoft use old 
module load gcc python 

source ~/rho/bin/activate

size=${1:-20} # size input 1 defaults to 20
NE=${2:-10000} # Ne input 2 defaults to 1k 
out="tables/sim_${size}_${NE}.table" # make output name 

# if > 50 then run moran else run normal 
if [[ ${size} -gt 50 ]] 
then 
	moran=$(printf "%.0f" "$(echo "scale=2; ${size} * 1.25" | bc)") # make moran + 25% rounded in integer 

	pyrho make_table --samplesize ${size} --approx --moran_pop_size ${moran} \
	 --numthreads 24 --mu 1.29e-8 --outfile ${out} \
	 --epochtimes 1 --popsizes ${NE},${NE}
else
	pyrho make_table --samplesize ${size} \
	 --numthreads 24 --mu 1.29e-8 --outfile ${out} \
	 --epochtimes 1 --popsizes ${NE},${NE}
fi
