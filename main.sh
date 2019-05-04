#!/bin/bash

#mnt_dir=$(mtp-detect | grep -A 1 Found  | grep -v Found | cut -d ':' -f1)

CON_DEV=$(jmtpfs -l | grep Device | wc -l)



echo -e \\n
for i in $(seq 1 $CON_DEV)
do
	echo "$i.$(jmtpfs -l | cut -d "," -f6 | sed '1,2d' | sed -n "${i}p")"
done
echo -e "\\nTotal Devices Connected With MTP : $CON_DEV\\n"

read -p "Select Device : " in

echo -e Mounting $(jmtpfs -l | cut -d "," -f6 | sed '1,2d' | sed -n "${in}p")

BUS=$(jmtpfs -l | cut -d "," -f1 | sed '1,2d' | sed -n "${in}p")
DEV=$(jmtpfs -l | cut -d "," -f2 | sed '1,2d' | sed -n "${in}p" | tr -d '[:space:]')
if $(jmtpfs -device=${BUS},${DEV} /mnt/OP5T)
then
	echo Mounting Successfull
else
	echo Failed
fi
