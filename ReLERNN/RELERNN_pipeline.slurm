#!/bin/bash

#SBATCH --job-name=ReLERNN-1.0.0-gpu-case

#SBATCH --partition=gpu

#SBATCH --ntasks=10

#SBATCH --gres=gpu:1

#SBATCH --time=02-00:00:00

#SBATCH --mail-user=*************

#SBATCH --mail0type=BEGIN,END


module load gcc/12.2.0 miniconda3/4.10.3 cudnn/8.4.0.27-11.6

source $CONDA_PROFILE/conda.sh

conda activate /mnt/apps/prebuilt/ReLERNN/gpu_env

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib

export XLA_FLAGS="--xla_gpu_cuda_data_dir=$CONDA_PREFIX/lib"

size=${1}
ne=${2}
vcf="../1.simulations/vcfs/sim_${size}_${ne}.vcf.gz"


##Simulate

ReLERNN_SIMULATE --vcf ${vcf} --genome ../1.simulations/genome.bed --seed 4

2 --unphased --assumedMu 1.29e-08 --nTrain 13000 --nTest 100 --nVali 2000

##Train


ReLERNN_TRAIN --seed 42


##Predict


ReLERNN_PREDICT --vcf ${vcf} --seed 42












