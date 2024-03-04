#!/bin/bash

# submit filenames to the sbatch function

for NAME in EBndG_100 EBndG_control
do
    for ID in 1 2 3 4 5 6 
    do
       sbatch polk-seq.sh $NAME $ID
    done
done

for NAME in EBndG_200 EBndG_20_control
do
    for ID in 1 2 3  
    do
       sbatch polk-seq.sh $NAME $ID
    done
done
