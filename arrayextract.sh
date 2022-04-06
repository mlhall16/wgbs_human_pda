#!/bin/bash -l
#SBATCH --job-name=Extract_%A_%a # Job name %A is the job number, %a is the array number
#SBATCH --nodes=1 # should never be anything other than 1
#SBATCH --ntasks=1 # number of cpus to use
#SBATCH --cpus-per-task=16
#SBATCH --time=12:00:00 # Format is hours:minutes:seconds
#SBATCH --mem-per-cpu=3G # Memory pool for each core
#SBATCH --partition=production # cluster partition
#SBATCH --output=/share/hwanglab/wgbs_human_pda/outerr/"stdout_%A_%a.out" # File to which STDOUT will be written, with job and array number
#SBATCH --error=/share/hwanglab/wgbs_human_pda/outerr/"stderr_%A_%a.err" # File to which STDERR will be written
#SBATCH --mail-type=ALL # sends emails when job starts and is completed
#SBATCH --mail-user=mlhhall@ucdavis.edu
#SBATCH --array 3-32 # tells slurm which numbers to use when running the job

aklog #allows slurm to access home directory (maybe doesn't work)

name=$(sed -n "$SLURM_ARRAY_TASK_ID"p /share/hwanglab/wgbs_human_pda/filelists/extractfilelist)
mypath="/share/hwanglab/wgbs_human_pda/aligned_files" # defines mypath variable to make code dryer

if [ ! -d "/tmp/${USER}" ]
then

mkdir /tmp/${USER}

fi # if /tmp/username directory does not exist, creates it

if [ ! -d "/tmp/${USER}/${SLURM_ARRAY_JOB_ID}" ]
then

mkdir /tmp/${USER}/${SLURM_ARRAY_JOB_ID}

fi # if /tmp/username/jobid directory does not exist, creates it

mkdir /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID} # makes a directory for the array number
scp ${mypath}/${name} /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID} # copies the first fastq file to temp directory
cd /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID} # goes to the temporary directory

module load bismark
srun bismark_methylation_extractor --multicore 5 -p --comprehensive --bedGraph --cytosine_report --genome_folder /share/hwanglab/wgbs_human_pda/HumanGenome -o /share/hwanglab/wgbs_human_pda/bismark_reports $name

rm /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID}/${name} # removes first fastq file from temp

cp -r /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID}/. /share/hwanglab/wgbs_human_pda/bismark_outputs # copies contents of temp directory to hwanglab
rm -rf /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID} # removes temp directory

