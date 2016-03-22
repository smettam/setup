#!/bin/bash  
for ((i=0; i<10; i++)); do

	#This creates string to output value for angle
        angle=$(echo "scale=3; $i*10" | bc | awk '{printf "%1.2f", $0}')
        echo $angle
	
	cd /scratch/pawsey0100/smettam/twoCylinders/R100_${angle}_2

	sbatch jobrun.sh

done
