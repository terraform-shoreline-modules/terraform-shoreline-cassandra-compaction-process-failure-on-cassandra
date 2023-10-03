
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Compaction Process Failure on Cassandra.
---

Compaction process failure on Cassandra is an incident where the compaction process of a Cassandra database fails to complete successfully. Compaction is a process of merging multiple SSTables (Sorted String Tables) into a single SSTable to optimize storage and improve read performance. When the compaction process fails, it can lead to issues such as increased disk usage, decreased read performance, and even data loss. This type of incident requires immediate attention from the operations team to fix the issue and prevent any further complications.

### Parameters
```shell
export PATH_TO_CASSANDRA_LOGS="PLACEHOLDER"

export CASSANDRA_NODE_IP="PLACEHOLDER"

export PATH_TO_CASSANDRA_CONFIG="PLACEHOLDER"

export PATH_TO_CASSANDRA_HOME="PLACEHOLDER"

export COMMA_SEPARATED_LIST_OF_CASSANDRA_NODES="PLACEHOLDER"

export CASSANDRA_JMXREMOTE_PORT="PLACEHOLDER"
```

## Debug

### Check Cassandra service status
```shell
systemctl status cassandra.service
```

### Check Cassandra logs for any errors related to compaction
```shell
grep -i "compaction" ${PATH_TO_CASSANDRA_LOGS}
```

### Check disk space on Cassandra nodes
```shell
df -h
```

### Verify network connectivity between Cassandra nodes
```shell
ping ${CASSANDRA_NODE_IP}
```

### Check Cassandra node status
```shell
nodetool status
```

### Check if compaction is running on any nodes
```shell
nodetool compactionstats
```

### Check Cassandra heap size
```shell
nodetool info | grep -i heap
```

### Check Cassandra configuration settings related to compaction
```shell
grep -i "compaction" ${PATH_TO_CASSANDRA_CONFIG}
```

## Repair

### Restart the Cassandra nodes to clear any temporary issues and try running the compaction process again.
```shell


#!/bin/bash



# Define variables

CASSANDRA_HOME=${PATH_TO_CASSANDRA_HOME}

CASSANDRA_NODES=${COMMA_SEPARATED_LIST_OF_CASSANDRA_NODES}



# Stop Cassandra nodes

echo "Stopping Cassandra nodes..."

$CASSANDRA_HOME/bin/nodetool stopdaemon -p ${CASSANDRA_JMXREMOTE_PORT} -h $CASSANDRA_NODES



# Wait for nodes to stop

echo "Waiting for Cassandra nodes to stop..."

sleep 10



# Start Cassandra nodes

echo "Starting Cassandra nodes..."

$CASSANDRA_HOME/bin/cassandra -p ${CASSANDRA_JMXREMOTE_PORT} -Dcassandra.join_ring=false -Dcassandra.start_rpc=true



# Wait for nodes to start

echo "Waiting for Cassandra nodes to start..."

sleep 30



# Run compaction process

echo "Running compaction process..."

$CASSANDRA_HOME/bin/nodetool compact -p ${CASSANDRA_JMXREMOTE_PORT} -h $CASSANDRA_NODES


```