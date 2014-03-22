#!/bin/sh

usage() {
echo "log_list <log file list> <start date YYYYMMDD> <end date YYYYMMDD>"
}

check_date() { 
result=`date -d $1 +%Y%m%d` > /dev/null 2>&1

if [ $1 = "$result" ]
then
		return 0
	else
		return 1
	fi
}

# CHECK ARGS
# 1st:loglist file. check exist
if [ ! \( -f $1 \) ]
then
	usage
	echo "Not Exist log file list name. $1"
	exit 1
fi

# 2nd 3rd:date start, end
check_date $2
if [ $? -ne 0 ]
then
	usage
	echo "Arg no.2 invalid date. $2"
	exit 1
fi

check_date $3
if [ $? -ne 0 ]
then
	usage
	echo "Arg no.3 invalid date. $3"
	exit 1
fi

# delete log file
rm "log_list_$2_$3.dat" > /dev/null 2>&1

# header
chk_date=$2
while [ $chk_date -le $3 ]
do
	days=`date -d "$chk_date" +"%Y/%m/%d"`
	disp_days="$disp_days	$days"
	chk_date=`date -d "$chk_date 1 day" +"%Y%m%d"`
done
echo "$disp_days"

# read log file list
while  read log_dir log_filename
do 
# date loop
	chk_date=$2
	while [ $chk_date -le $3 ]
	do
		logfile=`echo $log_filename | sed -e "s/YYYYMMDD/$chk_date/"`
		logfile=`echo $logfile | sed -e "s/HH/\*/"`
		filename="$log_dir/$logfile"
# check exist file
		if ls $filename > /dev/null 2>&1
		then
			rslt="	○"
			echo $logfile >> "log_list_$2_$3.dat"
		else
			rslt="	"
		fi
		results="$results$rslt"
		chk_date=`date -d "$chk_date 1 day" +"%Y%m%d"`
	done
	echo "$log_dir/$log_filename$results"
	results=""
done < $1

