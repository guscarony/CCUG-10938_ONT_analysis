#!/bin/bash
#SBATCH -A C3SE408-25-2
#SBATCH -J quast_analysis
#SBATCH -p vera
#SBATCH -N 1 --cpus-per-task=4
#SBATCH -t 01:00:00
#SBATCH --output=/path/to/logs/quast_%j.out
#SBATCH --error=/path/to/logs/quast_%j.err

# Load or use containerized QUAST
CONTAINER_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511-2026/containers/quast.sif"

# Set paths - ADJUST THESE TO YOUR ACTUAL PATHS
DATA_PATH="path/to/Assembly_reads"
RESULTS_PATH="/path/to/results"
OUTPUT_DIR="${RESULTS_PATH}/results/quast_results"

# Set the path to the assemblies (This should point to the directory containing the Flye assembly outputs)
ASSEMBLIES_DIR="${RESULTS_PATH}/assembly"

# Bind paths for container
export SINGULARITY_BINDPATH="${ASSEMBLIES_DIR}:/assemblies,${OUTPUT_DIR}:/output"

# Create output directory
mkdir -p ${OUTPUT_DIR}

# Run QUAST on both assemblies
singularity exec ${CONTAINER_PATH} quast.py \
    -o ${OUTPUT_DIR} \
    --threads 4 \
    --plots-format png \
    --labels "Basic,Polished" \
    /assemblies/flye_basic/assembly.fasta \
    /assemblies/flye_polished/assembly.fasta

echo "QUAST analysis completed"