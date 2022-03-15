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

Trim files using the script arrayalign.sh
*Change the array numbers to match the number of files
Finished 3/11/22

### Perform genome preparation

*Only needs to be done once
*hg38 genome is already done at `/share/hwanglab/genome/hg38bismark`
*Use the script `genomeprep.sh` (theoretically this works, but I ran it locally, so I'm not sure)

