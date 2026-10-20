#!/bin/bash
#SBATCH -A C3SE408-25-2
#SBATCH -J prokka_curated
#SBATCH -p vera
#SBATCH -N 1 --cpus-per-task=8
#SBATCH -t 01:00:00
#SBATCH --output=/cephyr/users/youruser/Vera/practical_3/logs/prokka_curated_%j.out # output log, adjust path to where you want to save logs
#SBATCH --error=/cephyr/users/youruser/Vera/practical_3/logs/prokka_curated_%j.err # error log, adjust path to where you want to save logs

# Simple copy/paste of "Prokka with curated proteins" from genome workflow, practical 3


# Set paths - ADJUST THESE TO YOUR ACTUAL PATHS
CONTAINER_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511-2026/containers/prokka.sif"
RESULTS_PATH="/path/to/results"
ASSEMBLIES_DIR="/path/to/data/assemblies"
CURATED_PROTEINS="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511-2026/refs/prokka_curated_refs/curatedRef.faa"

# Create output directories
mkdir -p ${RESULTS_PATH}

# Bind paths for container
export SINGULARITY_BINDPATH="${ASSEMBLIES_DIR}:/assemblies,${RESULTS_PATH}:/results,${CURATED_PROTEINS}:/curatedRef.faa"

# Input assembly
ASSEMBLY="/assemblies/GU10.fa"

# Set a prefix variable for naming outputs
PREFIX="$(basename ${ASSEMBLY} .fa)_curated"

# Run Prokka (curated)
singularity exec ${CONTAINER_PATH} prokka \
  --cpus 8 \
  --outdir ${RESULTS_PATH}/prokka_curated \
  --prefix ${PREFIX} \
  --locustag BIO511 \
  --genus Escherichia \
  --species coli \
  --proteins /curatedRef.faa \
  ${ASSEMBLY}

echo "Curated Prokka annotation completed"