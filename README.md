# POLK-seq

**submit-polk-seq.sh**": Bash script to call polk-seq.sh in the slurm environment to process the paired-end fastq.gz files into bam and bam.bai files

**bam2bigwig.sh**:  Converts the individual replicate EBndG-treated and untreated bam files into the log2.bw files using deeptools bamCompare function

**createMBS.sh**: Converts the set of bam files into a text file containing the number of reads within 100bp or 50Kb windoes using the deeptools multiBamSummary function.

**mbs2bedgraph.m**: Matlab script that normalizes the read count and creates a log2 bedgraph file for individual replicates as well as the average of the bedgraph files

**bedgraph2bigwig.sh**: Converts the bedgraph files from above to bigwig using the bedGraphToBigWig function
