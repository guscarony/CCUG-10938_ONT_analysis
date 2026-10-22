# CCUG-10938_ONT_analysis
premade containers at /cephyr/NOBACKUP/groups/n2bin_gu/students/_BIO511_containers
kraken2 db at /cephyr/NOBACKUP/groups/n2bin_gu/BIO511-2026/databases/kraken2_db

 ------UNDER CONSTRUCTION------

Some saved code for CLI analysis of ONT sequenced bacterial genome.
README provides an overview of workflow, sections of each step with 
- tool--version
- purpose
- expected input and output
    and when relevant;
- prep work and alternative resources. 

NOTES:
scripts with '_slurm' are templates for slurm jobs, other scripts are mostly terminal inputs, saved as scripts for easy access 
___________________________________________________________________
1 - Pre-analysis
- 1.0 FASTQ splitter
Split sample.fastq into sample_R1.fastq and sample_R2.fastq  
https://usegalaxy.org/?tool_id=toolshed.g2.bx.psu.edu%2Frepos%2Fdevteam%2Ffastq_paired_end_splitter%2Ffastq_paired_end_splitter%2F1.2%2Bgalaxy0&version=latest
    IDK, I just don't wanna bother with another CLI setup w more dependencies and whatnot. We've got enough to do


- 1.1 kraken2 (Version 2.17.1) 
quick check for contamination
New dabase uploaded to vera, I(C) still can't get it to work so I use: https://usegalaxy.org/?tool_id=toolshed.g2.bx.psu.edu%2Frepos%2Fiuc%2Fkraken2%2Fkraken2%2F2.17.1%2Bgalaxy0&version=latest
Database:

- 1.2 fastplong (fastp but for long reads)  
Quality control, trimming and filtering

(step to filter unpaired/unmatched reads?)

- 1.3 MultiQC
input: kraken2_results (.), fastp_results(.) (reports)
Prep work, create MultiQC dir structure:
multiqc_analysis/______ multiqc.sh
                    |__ <multiqc_output here?>
                    |__ QC_results/______ kraken2_results/
                                     |__ fastp_results/ 

2 - Assembly
- 2.1 Flye (Flye version 2.9.5-b1801)
de novo assembly

- 2.2 Quast ()
Assembly Quality assessment

- 2.3 MultiQC
also Assembly Quality assessment
input: flye_results, quast_results (reports)

- 2.4
polishing



3 - Annotation

- 3.1 Prokka
input <assembly>.fa

- 3.2 MultiQC
input: prokka_results (report)