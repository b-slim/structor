{
  "os": "ubuntu14",
  "hdp_short_version": "2.5.0",
  "vm_mem": 6144,
  "vm_cpus": 4,

  "am_mem": 512,
  "server_mem": 768,
  "client_mem": 1024,

  "security": true,
  "domain": "example.com",
  "realm": "EXAMPLE.COM",

  "clients" : [ "hbase", "hdfs", "hive", "odbc", "tez", "yarn" ],
  "nodes": [
    {"hostname": "hdp250-ubuntu", "ip": "192.168.59.11",
     "roles": ["client", "hbase-master", "hbase-regionserver", "hive-db", "hive-meta",
               "hive-server2", "kdc", "nn", "slave", "yarn", "yarn-timelineserver", "zk"]}
  ],

  "hive_options" : "interactive",

  "extras": [ "sample-hive-data" ]
}
