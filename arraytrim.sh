#!/bin/bash -l
#SBATCH --job-name=Trim_%A_%a # Job name %A is the job number, %a is the array number
#SBATCH --nodes=1 # should never be anything other than 1
#SBATCH --ntasks=1 # number of cpus to use
#SBATCH --cpus-per-task=9
#SBATCH --time=12:00:00 # Format is hours:minutes:seconds
#SBATCH --mem-per-cpu=4G # Memory pool for each core
#SBATCH --partition=production # cluster partition
#SBATCH --output=/share/hwanglab/wgbs_human_pda/outerr/"stdout_%A_%a.out" # File to which STDOUT will be written, with job and array number
#SBATCH --error=/share/hwanglab/wgbs_human_pda/outerr/"stderr_%A_%a.err" # File to which STDERR will be written
#SBATCH --mail-type=ALL # sends emails when job starts and is completed
#SBATCH --mail-user=mlhhall@ucdavis.edu
#SBATCH --array 1,13 # tells slurm which numbers to use when running the job

aklog #allows slurm to access home directory (maybe doesn't work)

name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p /share/hwanglab/wgbs_human_pda/trimfilelist1) # defines variable name1 as the first fastq file on list 1
name2=$(sed -n "$SLURM_ARRAY_TASK_ID"p /share/hwanglab/wgbs_human_pda/trimfilelist2) # defines variable name2 as the first fastq file on list 2 (paired)
mypath="/share/hwanglab/wgbs_human_pda/fastq" # defines mypath variable to make code dryer

if [ ! -d "/tmp/${USER}" ]
then

mkdir /tmp/${USER}

fi # if /tmp/username directory does not exist, creates it

if [ ! -d "/tmp/${USER}/${SLURM_ARRAY_JOB_ID}" ]
then

mkdir /tmp/${USER}/${SLURM_ARRAY_JOB_ID}

fi # if /tmp/username/jobid directory does not exist, creates it

mkdir /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID} # makes a directory for the array number
scp ${mypath}/${name1} /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID} # copies the first fastq file to temp directory
scp ${mypath}/${name2} /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID} # copies the second fastq file to the temp directory
cd /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID} # goes to the temporary directory

module load trim_galore # loads trim galore!
source activate cutadapt-3.4 # allows cutadapt to run
srun trim_galore -j 4 --paired $name1 $name2 # runs trim galore in paired mode on the fastq files using 16 cores

rm /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID}/${name1} # removes first fastq file from temp
rm /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID}/${name2} # removes second fastq file from temp

cp -r /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID}/. /share/hwanglab/wgbs_human_pda/trimmed_fastq # copies contents of temp directory to hwanglab
rm -rf /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID} # removes temp directory

