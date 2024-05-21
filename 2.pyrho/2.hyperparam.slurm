#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=144G
#SBATCH --job-name=hyperparam
#SBATCH --account jgoudet_barn_owl
#SBATCH -e RUNFILES/%x_%A_stderr
#SBATCH -o RUNFILES/%x_%A_stdout

#dcsrsoft use old 
module load gcc python 

source ~/rho/bin/activate

size=${1:-20} # defaults to 20 
NE=${2:-10000} # defaults to 10k
table="tables/sim_${size}_${NE}.table" # name of table file - can be recreated through sample + Ne 
out="hyperparams/sim_${size}_${NE}.hyperparam" # name of output - same but different suffix 
# run command 
pyrho hyperparam --samplesize ${size} --tablefile ${table} \
--mu 1.29e-08 --ploidy 2 --numthreads 12 \
--popsizes ${NE},${NE} --epochtimes 1 \
--outfile ${out}
