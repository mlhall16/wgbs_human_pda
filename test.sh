#!/bin/bash -l
#SBATCH --job-name=Trim_%A_%a # Job name %A is the job number, %a is the array number
#SBATCH --nodes=1 # should never be anything other than 1
#SBATCH --ntasks=1 # number of cpus to use
#SBATCH --cpus-per-task=1
#SBATCH --time=00:40:00 # Format is hours:minutes:seconds
#SBATCH --mem-per-cpu=1G # Memory pool for each core 
#SBATCH --partition=production # cluster partition
#SBATCH --output=/share/hwanglab/"stdout_%A_%a.out" # File to which STDOUT will be written, with job and array number
#SBATCH --error=/share/hwanglab/"stderr_%A_%a.err" # File to which STDERR will be written
#SBATCH --mail-type=ALL # sends emails when job starts and is completed
#SBATCH --mail-user=mlhhall@ucdavis.edu
#SBATCH --array 1-3 # tells slurm which numbers to use when running the job

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
ln -s ${mypath}/${name1} /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID} # creates a symbolic link to the first fastq file
ln -s ${mypath}/${name2} /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID} # creates a symbolic link to the second fastq file
cd /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID} # goes to the temporary directory

pwd > test_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} # lists the pathname of the temp directory in a file 
ls >> test_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} # lists the contests of the temp directory in the file
echo $name1 >> test_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} # lists name1 in the file
echo $name2 >> test_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID} # lists name2 in the file

rm /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID}/${name1} # removes symbolic link to file 1
rm /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID}/${name2} # removes symbolic link to file 2
cp -r /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID}/. /share/hwanglab/wgbs_human_pda # copies contents of temp directory to hwanglab
rm -rf /tmp/${USER}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID} # removes temp directory
