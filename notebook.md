# Lab Notebook for Patient Derived Organoid Analysis
## on Genome Center server

### Load in data

Navigate to server folder `/share/hwanglab/wgbs_human_pda`

```
rsync -aP 2nd\ Folder/ mlhall@barbera.genomecenter.ucdavis.edu:/share/hwanglab/wgbs_human_pda/fastq
```

*Make sure that the rsync version on Macs is updated (and not 12 years old)

### Trim files

Generate two files lists using the following commands

```
ls /share/hwanglab/wgbs_human_pda/fastq | grep ".*R1.*" > ~/pdo/trimfilelist1
ls /share/hwanglab/wgbs_human_pda/fastq | grep ".*R2.*" > ~/pdo/trimfilelist2
```

Trim files using the script arraytrim.sh
*Change the array numbers to match the number of files
Finished 3/11/22

### Perform genome preparation

*Only needs to be done once
*hg38 genome is already done at `/share/hwanglab/genome/hg38bismark`
*Use the script `genomeprep.sh` (theoretically this works, but I ran it locally, so I'm not sure)

### Alignment

Make file list using:
```
ls /share/hwanglab/wgbs_human_pda/trimmed_files | grep ".*fq.gz" > ~/pdo/alignfilelist
```
Using script arrayalign.sh

### Methylation Extraction
```
ls /share/hwanglab/wgbs_human_pda/aligned_files | grep ".*bam" > ~/pdo/extractfilelist
```
Use script arrayextract.sh- outputs CpG report, splitting report, bedGraph file, bismark coverage files, and reports for each context to /share/hwanglab/wgbs_human_pda/bismark_reports

### Job log

46849781- trimming of 2 test files
46853905- trimming of indices 3 to 20
46892798- trimming of indices 21 to 32
46965392- alignment attempted on test files, genome prep not completed properly
47038620- alignment attempted on test files, issue with tmp storage on server
47039091- same error as previous
47039095- alignment attempted on test files, timeout
47039335- alignment attempted on all files, timeout + can only run 3 at the same time due to storage limitations (fleet-28)
47221616- alignment on all files- cancelled, 30h is not quite enough alignment time, so it timed out
47259466- alignment on all files- 36h, successful for indices 4-12, 14, 16, 17 corresponding to samples 24-32, 34, 36, 37
	files 1 and 13 failed due to trimming issues (?), the rest had other issues
47261637- trimming on indices 1 and 13, successful
47271179- alignment for indices 1-3,13,15,18-31, successful for 1-3, 13, 15
47288792- alignment for indices 18-31, successful for all
47296187- methylation extraction troubleshooting, multiple issues
47296189- methylation extraction troubleshooting, issue with file selection, incorrect path to file list
47296191- methylation extraction troubleshooting, no file space on node, switched from dev to production
47342154- methylation extraction troubleshooting, saving issue
47359285- methylation extraction troubleshooting, fixed saving issue by outputting directly to share/hwanglab
47367832- methylation extraction for indices 3-32, all successful
47519596- qualimap troubleshooting, issue with file selection, incorrect path to file list
47519598- qualimap troubleshooting, need to sort bam input
47519600- qualimap troubleshooting, no space on node, switched to production node
47519602- qualimap troubleshooting
  
### Directory Structure

/share/hwanglab/
`-- wgbs_human_pda
    |-- aligned_files
    |   |-- bam_files
    |   |   `-- alignedfile_bismark_bt2_pe.bam
    |   `-- reports
    |       `-- alignmentreport_bismark_bt2_PE_report.txt
    |-- bismark_reports
    |	|-- bedgraph
    |   |   `-- sample_val_1_bismark_bt2_pe.bedGraph.gz  
    |   |-- context_files
    |   |   `-- context_sample_val_1_bismark_bt2_pe.txt 
    |   |-- coverage  
    |   |   `-- sample_val_1_bismark_bt2_pe.bismark.cov.gz
    |   |-- Mbias
    |   |   `-- sample_val_1_bismark_bt2_pe.M-bias.txt
    |   |-- report
    |   |   |-- sample_val_1_bismark_bt2_pe.CpG_report.txt
    |   |   `--	sample_val_1_bismark_bt2_pe_splitting_report.txt	
    |-- fastq
    |   |-- fastqfile_R1_001.fastq.gz
    |   `-- fastqfile_R2_001.fastq.gz
    |-- fastQC
    |   |-- 21_SNU_3898_S64_L002_R1_001_val_1_fastqc.html
    |   |-- 21_SNU_3898_S64_L002_R1_001_val_1_fastqc.zip
    |   |-- 21_SNU_3898_S64_L002_R2_001_val_2_fastqc.html
    |   `-- 21_SNU_3898_S64_L002_R2_001_val_2_fastqc.zip
    |-- filelists
    |   |-- alignfilelist1
    |   |-- alignfilelist2
    |   |-- trimfilelist1
    |   `-- trimfilelist2
    |-- Genomes
    |   |-- Bisulfite_Genome
    |   |   |-- CT_conversion
    |   |   |   |-- BS_CT.1.bt2
    |   |   |   |-- BS_CT.2.bt2
    |   |   |   |-- BS_CT.3.bt2
    |   |   |   |-- BS_CT.4.bt2
    |   |   |   |-- BS_CT.rev.1.bt2
    |   |   |   |-- BS_CT.rev.2.bt2
    |   |   |   `-- genome_mfa.CT_conversion.fa
    |   |   `-- GA_conversion
    |   |       |-- BS_GA.1.bt2
    |   |       |-- BS_GA.2.bt2
    |   |       |-- BS_GA.3.bt2
    |   |       |-- BS_GA.4.bt2
    |   |       |-- BS_GA.rev.1.bt2
    |   |       |-- BS_GA.rev.2.bt2
    |   |       `-- genome_mfa.GA_conversion.fa
    |   `-- hg38.fa
    |-- hg38.fa.gz
    |-- outerr
    |   `-- output_and_error_folders
    |-- stderr_gp.err
    |-- stdout_gp.out
    `-- trimmed_fastq
        |-- trimmedfiles_val_1.fq.gz
        |-- trimmedfiles_val_2.fq.gz
        `-- reports
            `-- trimmingreports.fastq.gz_trimming_report.txt
