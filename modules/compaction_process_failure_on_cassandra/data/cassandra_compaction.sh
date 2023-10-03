

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