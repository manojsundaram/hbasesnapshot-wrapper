# hbasesnapshot-wrapper

README:



This script will take a hbase table name as an input and will create a snapshot of it. Logs will be stored to ./logs/runs.txt
NOTE: The name of the snapshot is currently set to the current epoch time. If you need to take daily snapshots, I have left a commented out line that will change the snapshot name to "snapshot-YYYYMMDD".

Usage:
bash take_snapshot.sh <hbase_table_name>
