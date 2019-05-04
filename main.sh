#!/bin/bash

#mnt_dir=$(mtp-detect | grep -A 1 Found  | grep -v Found | cut -d ':' -f1)

CON_DEV=$(jmtpfs -l | grep Device | wc -l)
source ./copy.sh

#########################LISTING###################################
echo -e \\n
for i in $(seq 1 $CON_DEV)
do
	echo "$i.$(jmtpfs -l | cut -d "," -f6 | sed '1,2d' | sed -n "${i}p")"
done
echo -e "\\nTotal Devices Connected With MTP : $CON_DEV\\n"

#########################MOUNTING###################################

read -p "Select Device : " in


DEV_NAME=$(jmtpfs -l | cut -d "," -f6 | sed '1,2d' | sed -n "${in}p" | tr -d '[:space:]')
if [[ -d ~/$DEV_NAME ]]
then
	if grep ~/$DEV_NAME /etc/mtab
	then
		echo Already Mounted.... Starting Backup
		rsync_copy "$DEV_NAME"
	fi
	echo Directory $DEV_NAME Exist! Remove it?
	read choice
	case $choice in
		y|Y|yes|YES)
			rm -rf ~/$DEV_NAME
			;;
		n|N|no|NO)
			echo OKAY BYYY
			exit 0
			;;
		*)
			echo Invalid Choice
		        ;;
	esac	
fi
mkdir ~/$DEV_NAME
if [[ $? -eq 0 ]] 
then
	echo ~/$DEV_NAME Created
else
	exit 0
fi

echo Mounting $DEV_NAME
BUS=$(jmtpfs -l | cut -d "," -f1 | sed '1,2d' | sed -n "${in}p")
DEV=$(jmtpfs -l | cut -d "," -f2 | sed '1,2d' | sed -n "${in}p" | tr -d '[:space:]')
if $(jmtpfs -device=${BUS},${DEV} ~/$DEV_NAME)
then
	echo Mounting Successfull
else
	echo Failed
fi
echo Starting Backup 
rsync_copy "$DEV_NAME"
