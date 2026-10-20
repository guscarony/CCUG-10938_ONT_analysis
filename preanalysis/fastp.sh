#!usr/bin/bash
# code lines for CLI fastp analysis of paired end reads
# Can be run locally w/o problems (if small data file only?)
sample_ID=""
="${sample_ID}"
    # Create output dir
mkdir -p fastp_results

    # Default fastp analysis, maybe good for first check?
# fastp -i ${sample_ID}_R1.fastq.gz -I ${sample_ID}_R2.fastq.gz -o ${sample_ID}_R1_filtered.fastq.gz -O ${sample_ID}_R2_filtered.fastq.gz -h ${sample_ID}_fastp_report.html -j 	${sample_ID}_fastp_report.json

    # Specified fastp analysis
    # -i; data file | -I; data file, reverse read | -o; output/filtered data file | -O; output/filtered data file, reverse read | -h; HTML output | -j; .json output
    # cut; | -right ?? | -mean_quality; lowest quality score 30 (why mean tho??) | length_req; sorts out <50bp reads 
fastp -i ${sample_ID}_R1.fastq.gz -I ${sample_ID}_R2.fastq.gz -o ${sample_ID}_R1_filtered.fastq.gz -O ${sample_ID}_R2_filtered.fastq.gz -h ${sample_ID}_fastp_report.html -j ${sample_ID}_fastp_report.json --cut_right --cut_mean_quality 30 --length_required 50

    # Open fastp analysis report in web browser
open ${sample_ID}_fastp_report.html



## NOTE
# May need to install xdg-utils and set default browser to open html;
# sudo apt install xdg-utils # (loads of dependencies tho)
# export BROWSER=$PATH
# xdg-open ${sample_ID}_fastp_report.html