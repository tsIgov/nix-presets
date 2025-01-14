#!/bin/sh
getBusFor() {
	echo $(lspci -nn | grep -E -i --max-count=1 "\[(0300|0302|0380)\].*$1" | cut -d " " -f1)
}

getDecimalBusId() {
	part1=$(echo "$1" | cut -d':' -f1)
	part2=$(echo "$1" | cut -d':' -f2 | cut -d'.' -f1)
	part3=$(echo "$v1" | cut -d'.' -f2)

	part1=$(("0x$part1"))
	part2=$(("0x$part2")) 
	part3=$(("0x$part3"))

	echo "PCI:$part1:$part2:$part3" 
}

getJson() {
	echo "{"
	echo "    \"nvidia\": \"$NVIDIA\","
	echo "    \"intel\": \"$INTEL\","
	echo "    \"amd\": \"$AMD\""
	echo "}"
}


NVIDIA=$(getBusFor "nvidia") 
INTEL=$(getBusFor "intel") 
AMD=$(getBusFor "(amd|radeon)") 

if [ ! -z $NVIDIA ]; then
	NVIDIA=$(getDecimalBusId $NVIDIA)
fi

if [ ! -z $INTEL ]; then
	INTEL=$(getDecimalBusId $INTEL)
fi

if [ ! -z $AMD ]; then
	AMD=$(getDecimalBusId $AMD)
fi

getJson > $out
