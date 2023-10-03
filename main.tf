terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "compaction_process_failure_on_cassandra" {
  source    = "./modules/compaction_process_failure_on_cassandra"

  providers = {
    shoreline = shoreline
  }
}