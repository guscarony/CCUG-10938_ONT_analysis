#!/bin/bash
sample_ID=""


multiqc . --title "${sample_ID} - QC and Classification Summary" --filename "${sample_ID}_multiqc_report" --dirs --dirs-depth 2 --force
open practical2_multiqc_report.html
