#!/bin/bash
#SBATCH -A C3SE408-25-2 
#SBATCH -J prokka_baseline
#SBATCH -p vera
#SBATCH -N 1 --cpus-per-task=8
#SBATCH -t 01:00:00
#SBATCH --output=/output/prokka_baseline_%j.out 
#SBATCH --error=/error/prokka_baseline_%j.err 

# Set paths - ADJUST THESE TO YOUR ACTUAL PATHS
CONTAINER_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511-2026/containers/prokka.sif"
RESULTS_PATH="/path/to/results"
ASSEMBLIES_DIR="/path/to/data/assemblies"

assembly_ID=""

# Create output directories
# If needed: mkdir -p ${RESULTS_PATH}
mkdir -p ${RESULTS_PATH}

# Bind paths for container
export SINGULARITY_BINDPATH="${ASSEMBLIES_DIR}:/assemblies,${RESULTS_PATH}:/results"

# Input assembly
ASSEMBLY="${assembly_ID}"

# Set a prefix variable for naming outputs
PREFIX="$(basename ${ASSEMBLY} .fa)_baseline"

# Run Prokka (baseline)
singularity exec ${CONTAINER_PATH} prokka \
  --cpus 8 \
  --outdir /results/prokka_baseline \
  --prefix ${PREFIX} \
  --locustag BIO511 \
  --genus Escherichia \
  --species coli \
  ${ASSEMBLY}

echo "Baseline Prokka annotation completed"