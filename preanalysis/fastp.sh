#!usr/bin/bash
# code lines for CLI fastp analysis of paired end reads
# Can be run locally w/o problems

    # Create output dir
mkdir -p fastp_results

    # Default fastp analysis
    # 
fastp -i sample1_R1.fastq.gz -I sample1_R2.fastq.gz -o sample1_R1	_filtered.fastq.gz -O sample1_R2_filtered.fastq.gz -h sample1_fastp_report.html -j 	sample1_fastp_report.json

    # Specified fastp analysis
    # -i; data file | -I; data file, reverse read | -o; output/filtered data file | -O; output/filtered data file, reverse read | -h; HTML output | -j; .json output
    # cut; | -right ?? | -mean_quality; lowest quality score 30 (why mean tho??) | length_req; sorts out <50bp reads 
fastp -i sample1_R1.fastq.gz -I sample1_R2.fastq.gz -o sample1_R1_filtered.fastq.gz -O sample1_R2_filtered.fastq.gz -h sample1_fastp_report.html -j sample1_fastp_report.json --cut_right --cut_mean_quality 30 --length_required 50

    # Open fastp analysis report in web browser
open sample1_fastp_report.html