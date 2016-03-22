#!/bin/bash  
for ((i=0; i<10; i++)); do
	
        #This creates string to output value for angle
	angle=$(echo "scale=3; $i*10" | bc | awk '{printf "%1.2f", $0}') 
	echo $angle
	
        #This creates string to output value for Re
	#Change Re in /constant/transportproperties preior to creating cases
	Re=$(echo "scale=3; 100" | bc | awk '{printf "%d", $0}')
	echo $Re

	#This creates string to output value for cylinder spacing
	#Change cylinder spacing in mesh prior to creating cases
	Spacing=$(echo "scale=3; 2" | bc | awk '{printf "%d", $0}')
	echo $Spacing

	#This creates string to output x,y angle variables to 10 decimal places
	xdirection=$(echo "c($i*10*4*a(1)/180)" | bc -l | awk '{printf "%1.15f", $0}') 
	echo $xdirection

	ydirection=$(echo "s($i*10*4*a(1)/180)" | bc -l | awk '{printf "%1.15f", $0}') 
	echo $ydirection
	
        #This sets up directory NAME
	NAME=R${Re}_${angle}_${Spacing}
	cd /mnt/run/
	mkdir $NAME
	cp -r testCase/* $NAME
	
	sed -i s/1.0000000/$xdirection/g $NAME/0/include/initialConditions
	
	sed -i s/0.0000000/$ydirection/g $NAME/0/include/initialConditions

	#sed -i s/4.250000000/$amplitude/g ./$NAME/VIV.xml
done

