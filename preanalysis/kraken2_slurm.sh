#!/bin/bash

# Create SLURM job script for kraken2 analysis
#SBATCH -A C3SE408-25-2
#SBATCH -J kraken2_job
#SBATCH -p vera
#SBATCH -N 1 --cpus-per-task=12 # Request 1 node with 12 CPUs
#SBATCH -t 01:00:00
#SBATCH --output=./results/kraken2_%j.out
#SBATCH --error=./error/kraken2_%j.err

#### OBS! Plug in variables for analysis work  
sample_ID=""                   # include file extensions (or add extension variable?)
input_path=""
output_path="./results"

# Look, I get that it's unnecessary to assign and then reassign variables, but
# I want the job specific variables up here, but I don't dare change anything down there (right now), then I will have endless problems even if it should be a'okay

# Preset path for container and database
CONTAINER_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511-2026/containers/kraken2.sif"
DB_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511-2026/refs/kraken2db"

# data paths
DATA_PATH="${input_path}"
RESULTS_PATH="${output_path}"

# Bind paths for container
export SINGULARITY_BINDPATH="${DB_PATH}:/db,${DATA_PATH}:/data,${RESULTS_PATH}:/results"

# Create results directory
mkdir -p ${RESULTS_PATH}

# Identify sample (change this to run the rest)
sample="${sample_ID}"
echo "Processing sample: ${sample}"

# Run Kraken2 classification
srun singularity exec ${CONTAINER_PATH} kraken2 \
        --db /db \
        --threads 8 \
        --paired \
        --output /results/${sample_ID}_kraken2_output.txt \
        --report /results/${sample_ID}_kraken2_report.txt \
        --classified-out /results/${sample_ID}_classified#.fastq \
        --unclassified-out /results/${sample_ID}_unclassified#.fastq \
        /data/${sample}_R1.fastq.gz /data/${sample_ID}_R2.fastq.gz

echo "Completed classification for ${sample_ID}"

echo "All samples processed successfully"