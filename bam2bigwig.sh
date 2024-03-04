#!/bin/batch -l
#SBATCH --job-name=bam2bw
#SBATCH --output=results_%j.txt
#SBATCH --error=error_%j.txt
#SBATCH --ntasks=1
#SBATCH --time=40:00:00
#SBATCH -p compute
#SBATCH -A lab_spratt

# Sbatch Script to create log2.bw of each replicate 
# location and name of blacklist bed file 
BL=/gpfs/location/blacklist.bed 
module load deeptools 
for ID in 1 2 3 4 5 6 
do
  bamCompare -b1 EBndG_100_Rep${ID}.bam -b2 EBndG_control.Rep.${ID}.bam \
             --binsize 100 \
             --blackListFileName $BL \
             --extendReads \
             --outFileName EBndG.100.Rep${ID}.log2.bw
done


for ID in 1 2 3  
do
  bamCompare -b1 EBndG_20.Rep${ID}.bam -b2 EBndG_20_control.Rep${ID}.bam \
             --binsize 100 \
             --blackListFileName ${BL}.bed \
             --outFileName EBndG.100.Rep${ID}.log2.bw
done
