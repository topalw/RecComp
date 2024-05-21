#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=24G
#SBATCH --job-name=optimize
#SBATCH --account jgoudet_barn_owl
#SBATCH -e RUNFILES/%x_%A_stderr
#SBATCH -o RUNFILES/%x_%A_stdout

#dcsrsoft use old 
module load gcc python 

source ~/rho/bin/activate

size=${1}
ne=${2}
# assumes vcf is name sim_size_ne.vcf.gz
vcf="vcfs/${size}_${ne}.vcf.gz"
# assumes a tab-delimited hyperparam.file with: size ne w bp
w=`grep "${size}\t${ne}" hyperparam.file | cut -f 3`
bp=`grep "${size}\t${ne}" hyperparam.file | cut -f 4`
out="optimize/sim_${size}_${ne}.opt"
table="tables/sim_${size}_${ne}.table"

pyrho optimize --vcffile ${vcf} --windowsize ${w} --blockpenalty ${bp} --tablefile ${table} --ploidy 2 --numthreads 12 --outfile ${out}


