#!/bin/bash
#SBATCH -A C3SE408-25-2
#SBATCH -J fastplong_job
#SBATCH -p vera
#SBATCH -N 1 --cpus-per-task=12   # Request 1 node with 12 CPUs
#SBATCH -t 01:00:00
#SBATCH --output=/cephyr/users/alflindb/Vera/n2bin_gu/students/Alfred/logs/fastplong_%j.out  # NB: this directory must already exist
#SBATCH --error=/cephyr/users/alflindb/Vera/n2bin_gu/students/Alfred/logs/fastplong_%j.err   # NB: this directory must already exist

#### Shamelessly and consentually stolen from Alfred 

set -euo pipefail

# ---------- Container ----------

CONTAINER_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/students/_BIO511_containers/fastplong.sif"

# ---------- Paths ----------
DATA_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/BIO511-2026/data/ONT_BIO511"
RESULTS_PATH="/cephyr/NOBACKUP/groups/n2bin_gu/students/Alfred/project_stuff/project_results"

# ---------- Sample and fastplong settings ----------
sample="DSM105256"



INPUT_NAME="DSM105256_ONT.fastq.gz"

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
    ls "${DATA_PATH}" | grep "${sample}" >&2 || true
    exit 1
fi

echo "Processing sample: ${sample}"


srun apptainer exec \
    -B "${DATA_PATH}:/data,${RESULTS_PATH}:/results" \
    "${CONTAINER_PATH}" \
    fastplong \
        -i "/data/${INPUT_NAME}" \
        -o "/results/${sample}_fastplong_clean.fastq.gz" \
        -q "${QUAL}" \
        -m "${MEAN_Q}" \
        -l "${MIN_LEN}" \
        -f "${TRIM_FRONT}" \
        -w "${THREADS}" \
        -h "/results/${sample}_fastplong.html" \
        -j "/results/${sample}_fastplong.json"

echo "Completed fastplong for ${sample}"