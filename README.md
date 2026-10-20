# CCUG-10938_ONT_analysis

Some saved code for CLI analysis of ONT sequenced bacterial genome.
Primarily scripts for analysis, but when unavailable, find relevant resources below:

- 1 - Pre-analysis
1.0 FASTQ splitter
Split sample.fastq into sample_R1.fastq and sample_R2.fastq  
https://usegalaxy.org/?tool_id=toolshed.g2.bx.psu.edu%2Frepos%2Fdevteam%2Ffastq_paired_end_splitter%2Ffastq_paired_end_splitter%2F1.2%2Bgalaxy0&version=latest

1.1 kraken2
quick check for contamination
communal kraken2-db temporarily gone (New upload to Vera on its way).
For now, use; 
https://usegalaxy.org/?tool_id=toolshed.g2.bx.psu.edu%2Frepos%2Fiuc%2Fkraken2%2Fkraken2%2F2.17.1%2Bgalaxy0&version=latest
Database:


1.2 fastp
Quality control, trimming and filtering

1.3 MultiQC

- 2 - Assembly

