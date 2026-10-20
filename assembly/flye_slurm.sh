#!/bin/bash
#SBATCH -A C3SE408-25-2
#SBATCH -J flye_polished
#SBATCH -p vera  
#SBATCH -N 1 --cpus-per-task=12
#SBATCH -t 02:30:00
#SBATCH --output=results/quast_%j.out
#SBATCH --error=error/quast_%j.err

# Set sample variables
sample_ID=""


# Set paths (remember paths in slurm lines too^)
DATA_PATH="path/to/Assembly_reads"
RESULTS_PATH="/path/to/results"
SINGULARITY_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511-2026/containers/flye.sif"

# Set bind paths for Singularity
export SINGULARITY_BINDPATH="${DATA_PATH}:/data,${RESULTS_PATH}:/results"

# Set sample and output paths
ONT_READS="${DATA_PATH}/${sample_ID}.fastq.gz"
OUTPUT_DIR="${RESULTS_PATH}/assembly/flye_polished"

# Create output directories
mkdir -p ${OUTPUT_DIR}

# Run Flye assembly with enhanced polishing
singularity exec ${SINGULARITY_PATH} flye --nano-raw /data/${sample_ID}.fastq.gz \
     --out-dir /results/assembly/flye \
     --threads 12 \
     --iterations 5 \

echo "Polished ONT assembly completed"