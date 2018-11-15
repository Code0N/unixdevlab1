#!/bin/bash

toArchive=0
extractf=0
extension=".csbk"

while [[ $1 ]]; do
	if [[ $1 = "-s" ]]; then
		shift
		sourceDir=$1
	elif [[ $1 = "-d" ]]; then
		shift
		destDir=$1
	elif [[ $1 = "-c" ]]; then
		shift
		bcount=$1
	elif [[ $1 = "-C" ]]; then
		toArchive=1
	elif [[ $1 = "-e" ]]; then
		extractf=1
	elif [[ $1 = "-n" ]]; then
		shift
		fname=$1
	fi
	shift
done




archive(){
	if [[ $3 -eq 2 ]]; then
		thecommand="tar -czf"
	else
		thecommand="tar -cf"
	fi

	$thecommand $2 $1
}

extract(){
	tar -xf $2 -C $1
}


if [[ $toArchive -eq 0 ]]; then
	read -p "Compress backups? 1 / 2 > " toArchive
fi

while [ $(ls $destDir | wc -l) -gt $bcount ]; do
	name="$(ls "$destDir" | head -1)"
	rm "$destDir/$name"
done

if [[ -z $fname ]]; then
	arcname="backup$(date +%s)$extension"
else
	arcname=$fname
fi

if [[ $extractf = 0 ]]; then
	archive "$sourceDir" "$destDir/$arcname" $toArchive
else
	extract "$sourceDir/extracted" "$destDir/$arcname"
fi