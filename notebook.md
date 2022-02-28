# Lab Notebook for Patient Derived Organoid Analysis
## on Genome Center server

### Load in data

Navigate to server folder `WGBS_humanPDA`

```
rsync -aP 2nd\ Folder/ mlhall@barbera.genomecenter.ucdavis.edu:/share/hwanglab
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


