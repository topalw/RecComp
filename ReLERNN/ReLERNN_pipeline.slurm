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

module load gcc python

source ~/rho/bin/activate

SIZE=${1}
NE=${2}
SIMULATE="ReLERNN_SIMULATE"
TRAIN="ReLERNN_TRAIN"
PREDICT="ReLERNN_PREDICT"
BSCORRECT="ReLERNN_BSCORRECT"
SEED="42"
MU="1.29e-8"
VCF = "../1.simulations/vcf/sim_${SIZE}_${NE}.vcf.gz"
GENOME = "../1.simulations/genome.bed"

# Simulate data
${SIMULATE} \
    --vcf ${VCF} \
    --genome ${GENOME} \
    --mask ${MASK} \
    --projectDir ${DIR} \
    --assumedMu ${MU} \
    --upperRhoThetaRatio ${URTR} \
    --nTrain 13000 \
    --nVali 2000 \
    --nTest 100 \
    --seed ${SEED}

# Train network

${TRAIN} \
    --seed ${SEED}

# Predict

${PREDICT} \
    --vcf ${VCF} \
    --seed ${SEED}

# Parametric Bootstrapping

${BSCORRECT} \
    --projectDir ${DIR} \
    --seed ${SEED}

