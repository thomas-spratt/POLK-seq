#!/bin/bash -l
#SBATCH --job-name=toBW
#SBATCH --ntasks=1
#SBATCH --time=48:00:00
#SBATCH --output=toBW.output.txt
#SBATCH --error=toBW.error.txt
#SBATCH -p compute
#SBATCH -A lab_spratt


module load bedGraphToBigWig

genomeSize=/location/GRCh38/hg38.genome.size

bedGraphToBigWig EBndG.100.50K.bg   ${genomeSize}   EBndG_100.50K.bw
bedGraphToBigWig EBndG.20.50K.bg   ${genomeSize}   EBndG_20.50K.bw
