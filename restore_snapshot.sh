#!/bin/bash
# Usage:
# bash restore_snapshot.sh <snapshot_name> <target_table_name> <source_hbase_dir> <destination_hbase_dir>
# example:
# bash restore_snapshot.sh snapshot-20170302 datapoints hdfs://prod.cloudera.com:8020/hbase hdfs://dr.cloudera.com:8020/hbase

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

#export TS=`date +"%Y%m%d"`

export TS=`date "+%s"`
export WORKING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export LOGS=$WORKING_DIR/logs
mkdir -p $LOGS

if [ -z $4 ] || [ $1 == '-h' ]
then
	echo "Usage: $WORKING_DIR/$0 <snapshot_name> <target_table_name> <source_hbase_dir> <destination_hbase_dir>"
	exit 1;
fi

echo "Importing snapshot..."
hbase org.apache.hadoop.hbase.snapshot.ExportSnapshot -snapshot $1 -copy-from $3 -copy-to $4

status=$?
if [ $status -eq 0 ]
then
	echo "Importing data into table: $2" $LOGS/import.txt
	echo "clone_snapshot '$1','$2'" | /usr/bin/hbase shell -n 2>> $LOGS/import.txt
else
	echo "Error during snapshot import"
fi
exit $status
