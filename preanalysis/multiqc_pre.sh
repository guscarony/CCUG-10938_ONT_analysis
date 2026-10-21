#!/bin/bash
sample_ID=""


multiqc . --title "${sample_ID} - QC and Classification Summary" --filename "${sample_ID}_multiqc_report" --dirs --dirs-depth 2 --force
open ${sample_ID}_multiqc_report.html










## NOTE
# May need to install xdg-utils and set default browser to open html;
# sudo apt install xdg-utils # (loads of dependencies tho)
# export BROWSER=$PATH
# xdg-open ${sample_ID}_fastp_report.html