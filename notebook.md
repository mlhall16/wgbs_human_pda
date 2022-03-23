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
47271179- alignment for indices 1-3,13,15,18-31
