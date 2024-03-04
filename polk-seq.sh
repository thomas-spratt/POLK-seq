#!/bin/bash -l
#SBATCH --job-name=pol-seq_%j
#SBATCH --output=results_%j.txt
#SBATCH --error=error_%j.txt
#SBATCH --ntasks=1
#SBATCH --time=40:00:00
#SBATCH -p compute
#SBATCH -A lab_spratt

# Use appropriate code to run a sbatch job on the slurm system 

# The location of the fastq.gz files and the output sam, bam files will be the current directory 

# load the programs 
module load bowtie2
module load 

# The names and ID will be submitted by the bash program submit-polk-seq.sh
NAME=$1
ID=$2

# replace with location of reference genome 
hg=/gpfs/location/hg38.reference 

# map reads, where $hg is location of reference genome
 bowtie2 -x $hg -1 ${NAME}_Rep${ID}_R1.fastq.gz -2 ${Name}_Rep${ID}_R2.fastq.gz  -S ${Name}Rep.${ID}.sam

 # Get mapped reads 
 samtools view -h -F 4 -o ${Name}Rep${ID}.map.sam ${Name}Rep${ID}.sam 
  
# sam to bam
 samtools view -b ${Name}Rep${ID}.map.sam -o ${Name}Rep${ID}.map.bam

# mark duplicates  
samtools fixmate -m ${Name}Rep${ID}.map.bam ${Name}Rep${ID}.fixmate.bam
rm ${Name}Rep.${ID}.map.bam

# sort File by position
samtools sort -o ${Name}Rep${ID}.sort.bam  ${Name}Rep${ID}.fixmate.bam 
rm ${Name}Rep.${ID}.fixmate.bam 

# remove duplicates
samtools markdup -r ${Name}Rep${ID}.sort.bam   ${Name}Rep${ID}.bam
rm ${Name}Rep${ID}.sort.bam 

# index file
samtools index ${Name}Rep${ID}.bam
