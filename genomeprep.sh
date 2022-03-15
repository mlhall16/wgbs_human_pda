#!/bin/bash -l
#SBATCH --job-name=GenomePrep
#SBATCH --nodes=1 # should never be anything other than 1
#SBATCH --ntasks=1 # number of cpus to use
#SBATCH --cpus-per-task=8
#SBATCH --time=03:00:00 # Format is hours:minutes:seconds
#SBATCH --mem-per-cpu=4G # Memory pool for each core
#SBATCH --partition=production # cluster partition
#SBATCH --output=/share/hwanglab/wgbs_human_pda/"stdout_gp.out" # File to which STDOUT will be written, with job and array number
#SBATCH --error=/share/hwanglab/wgbs_human_pda/"stderr_gp.err" # File to which STDERR will be written
#SBATCH --mail-type=ALL # sends emails when job starts and is completed
#SBATCH --mail-user=mlhhall@ucdavis.edu

aklog

mkdir /tmp/${USER}
mkdir /tmp/${USER}/GenomePrep
cd /tmp/${USER}/GenomePrep

cp /share/hwanglab/wgbs_human_pda/hg38.fa.gz /tmp/${USER}/GenomePrep

module load bismark
srun bismark_genome_preparation --verbose /tmp/${USER}/GenomePrep/ #make sure this is a path to the directory not the file

cp -r /tmp/${USER}/GenomePrep/ /share/hwanglab/wgbs_human_pda
