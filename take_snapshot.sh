#!/bin/bash
# Usage:
# bash take_snapshot.sh table_name

# DISCLAIMER
# Please note: This script is released for use "AS IS" without any warranties
# of any kind, including, but not limited to their installation, use, or
# performance. We disclaim any and all warranties, either express or implied,
# including but not limited to any warranty of noninfringement,
# merchantability, and/ or fitness for a particular purpose. We do not warrant
# that the technology will meet your requirements, that the operation thereof
# will be uninterrupted or error-free, or that any errors will be corrected.
#
# Any use of these scripts and tools is at your own risk. There is no guarantee
# that they have been through thorough testing in a comparable environment and
# we are not responsible for any damage or data loss incurred with their use.
#
# You are responsible for reviewing and testing any scripts you run thoroughly
# before use in any non-testing environment.

# For daily snapshot format (named with YYMMDD)
#export TS=`date +"%Y%m%d"`

# For frequent snapshots (named with the epoch time)
export TS=`date "+%s"`
export WORKING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export LOGS=$WORKING_DIR/logs
mkdir -p $LOGS

if [ -z $1 ] || [ $1 == '-h' ]
then
	echo "Usage: $WORKING_DIR/$0 <table>"
	exit 1;
fi

echo "New snapshot... table $1:snapshot-$TS" >> $LOGS/runs.txt

echo "snapshot '$1', 'snapshot-$TS'" | /usr/bin/hbase shell -n 2>> $LOGS/runs.txt 
status=$?

if [ $status -ne 0 ];
then
	echo "Snapshot may have failed: $status" >> $LOGS/runs.txt
fi
exit $status
