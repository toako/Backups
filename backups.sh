#!/bin/bash

#Define Functions at top before calling them basically

function total_files {
	find $1 -type f | wc -l
	
}

function total_directories {
	find $1 -type d | wc -l	

}

function where {

echo -e "\e[31;43mWhere would you like your backups?\e[0m"
read dest

}

function everything {

ls -ahl &> logEverything.txt

}


clear
echo -e "\e[31;43mMaking a tar backup of my BASH directory, press any key to continue\e[0m"
read -p " " -n1 -s
echo
day=$(date +%A)
month=$(date +%B)
year=$(date +%Y)
numberday=$(date +%d)

echo -e "\e[106mDayName: $day\e[0m"
echo -e "\e[106mDayDate: $numberday\e[0m"
echo -e "\e[106mMonth: $month\e[0m"
echo -e "\e[106mYear: $year\e[0m"
echo 
echo
cal
echo


# hostname infomation
echo -e "\e[31;43m***** Hostname Information *****\e[0m"
hostnamectl
echo " "

# filesystem disk space useage
echo -e "\e[31;43m***** Filesystem disk space useage *****\e[0m"
df -h
echo " "

# Memory -- free and used
echo -e "\e[31;43m***** Memory Information *****\e[0m"
free -h
echo " "

# system uptime and performace load
echo -e "\e[31;43m***** System Uptime and Performace Load *****\e[0m"
uptime
echo " "

# users currently logged in
echo -e "\e[31;43m***** Users Currently Logged In *****\e[0m"
who
echo " "

# top5 processes
echo -e "\e[31;43m***** Top 5 Processes *****\e[0m"
ps -eo %mem,%cpu,comm --sort=-%mem | head -n 6
echo " "

# folder / dest = destination src = source (don't use 'source' since it is a keyword)
######Assignment############
#Ask where the destination is
#put files in the destinations
#1 or more functions

where
src=~/bash

echo "Number of files in $src --"
total_files $src

echo "Number of directories in /home/compsci --"
total_directories $(/home/compsci)

if [ -d $dest ]; then
echo -e "\e[31;43mBackup folder exists\e[0m"
else
echo -e "\e[31;43mBackup folder does not exist, creating it now ...\e[0m"
mkdir -p $dest
echo
fi

read -p "press any key to continue" -n1 -s
mkdir -p $dest/"$dayName $dayDate $month $year"
echo

echo -e "\e[31;43mBackup Started\e[0m"
tar cvfz $dest/"$dayName $dayDate $month $year"/bash_backup.tgz $src

echo
echo -e "\e[31;43mHere are the contents of your backup directory:\e[0m"
cd $dest
everything
echo
echo -e "\e[31;43mAnd here is what is inside that directory:\e[0m"
cd "$dayName $dayDate $month $year"
ls -ahl 2> logErrors.txt

echo

echo -e "\e[31;43mAll done, press [enter] to exit\e[0m"
read -p ""
cd~
clear
