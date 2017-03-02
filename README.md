# hbasesnapshot-wrapper

 DISCLAIMER

 Please note: This script is released for use "AS IS" without any warranties
 of any kind, including, but not limited to their installation, use, or
 performance. We disclaim any and all warranties, either express or implied,
 including but not limited to any warranty of noninfringement,
 merchantability, and/ or fitness for a particular purpose. We do not warrant
 that the technology will meet your requirements, that the operation thereof
 will be uninterrupted or error-free, or that any errors will be corrected.

 Any use of these scripts and tools is at your own risk. There is no guarantee
 that they have been through thorough testing in a comparable environment and
 we are not responsible for any damage or data loss incurred with their use.

 You are responsible for reviewing and testing any scripts you run thoroughly
 before use in any non-testing environment.

# 
<b>CREATING SNAPSHOT (on the source cluster):</b>

This script will take a hbase table name as an input and will create a snapshot of it. Logs will be stored to ./logs/runs.txt
NOTE: The name of the snapshot is currently set to the current epoch time. If you need to take daily snapshots, I have left a commented out line that will change the snapshot name to "snapshot-YYYYMMDD".

Usage:
bash take_snapshot.sh <hbase_table_name>

Example:
bash take_snapshot.sh table_name

#
<b>IMPORTING SNAPSHOT AND CLONING LOCALLY (on the destination cluster)</b>

This script will import a hbase snapshot from a remote cluster and clone it to a local hbase table.

Usage:
bash restore_snapshot.sh <snapshot_name> <target_table_name> <source_hbase_dir> <destination_hbase_dir>

Example:
bash restore_snapshot.sh snapshot-20170302 datapoints hdfs://prod.cloudera.com:8020/hbase hdfs://dr.cloudera.com:8020/hbase

Note: This step can be done on the source side itself by exporting the snapshot and then cloning it locally on the destination side. But that wouldn't work in a case where the replication factor on destination side is lesser than the source side.
