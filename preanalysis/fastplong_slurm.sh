#!/bin/bash
#SBATCH -A C3SE408-25-2
#SBATCH -J fastplong_job
#SBATCH -p vera
#SBATCH -N 1 --cpus-per-task=12   # Request 1 node with 12 CPUs
#SBATCH -t 01:00:00
#SBATCH --output=/output/fastplong_%j.out  # NB: this directory must already exist
#SBATCH --error=/error/fastplong_%j.err   # NB: this directory must already exist

#### Shamelessly and consentually stolen from Alfred 

set -euo pipefail

# ---------- Paths ----------
sample_ID=""                # include file extensions (or add extension variable?)
DATA_PATH=""
RESULTS_PATH=""

# ---------- Container ----------

CONTAINER_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/students/_BIO511_containers/fastplong.sif"



# ---------- Sample and fastplong settings ----------




INPUT_NAME="${sample_ID}"

MIN_LEN=1000     # -l  minimum read length (bp)
MEAN_Q=10        # -m  minimum mean read quality
QUAL=15          # -q  per-base qualified quality threshold
TRIM_FRONT=0     # -f  bases trimmed from read start
# fastplong thread count follows the CPUs requested above
THREADS="${SLURM_CPUS_PER_TASK}"

# ---------- Run ----------
mkdir -p "${RESULTS_PATH}"

if [[ ! -f "${DATA_PATH}/${INPUT_NAME}" ]]; then
    echo "ERROR: ${DATA_PATH}/${INPUT_NAME} not found. Files present:" >&2
    ls "${DATA_PATH}" | grep "${sample_ID}" >&2 || true
    exit 1
fi

echo "Processing sample: ${sample_ID}"


srun apptainer exec \
    -B "${DATA_PATH}:/data,${RESULTS_PATH}:/results" \
    "${CONTAINER_PATH}" \
    fastplong \
        -i "/data/${INPUT_NAME}" \
        -o "/results/${sample_ID}_fastplong_clean.fastq.gz" \
        -q "${QUAL}" \
        -m "${MEAN_Q}" \
        -l "${MIN_LEN}" \
        -f "${TRIM_FRONT}" \
        -w "${THREADS}" \
        -h "/results/${sample_ID}_fastplong.html" \
        -j "/results/${sample_ID}_fastplong.json"

echo "Completed fastplong for ${sample_ID}"