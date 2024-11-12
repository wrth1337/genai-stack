#!/bin/bash

# this is called from docker-compose.yml to seed the databases
# relies on NEO4_ADDRESS, NEO4J_USERNAME, NEO4J_PASSWORD environment variables

if [ ! -d /data/databases/neo4j ]; then
  neo4j-admin database load neo4j --from-path=/backups --verbose;
fi
