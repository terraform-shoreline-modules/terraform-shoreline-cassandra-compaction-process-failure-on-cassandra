resource "shoreline_notebook" "compaction_process_failure_on_cassandra" {
  name       = "compaction_process_failure_on_cassandra"
  data       = file("${path.module}/data/compaction_process_failure_on_cassandra.json")
  depends_on = [shoreline_action.invoke_cassandra_compaction]
}

resource "shoreline_file" "cassandra_compaction" {
  name             = "cassandra_compaction"
  input_file       = "${path.module}/data/cassandra_compaction.sh"
  md5              = filemd5("${path.module}/data/cassandra_compaction.sh")
  description      = "Restart the Cassandra nodes to clear any temporary issues and try running the compaction process again."
  destination_path = "/agent/scripts/cassandra_compaction.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_cassandra_compaction" {
  name        = "invoke_cassandra_compaction"
  description = "Restart the Cassandra nodes to clear any temporary issues and try running the compaction process again."
  command     = "`chmod +x /agent/scripts/cassandra_compaction.sh && /agent/scripts/cassandra_compaction.sh`"
  params      = ["PATH_TO_CASSANDRA_HOME","COMMA_SEPARATED_LIST_OF_CASSANDRA_NODES","CASSANDRA_JMXREMOTE_PORT"]
  file_deps   = ["cassandra_compaction"]
  enabled     = true
  depends_on  = [shoreline_file.cassandra_compaction]
}

