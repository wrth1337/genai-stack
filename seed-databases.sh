#!/bin/bash

# this is called from docker-compose.yml to seed the databases
# relies on NEO4_ADDRESS, NEO4J_USERNAME, NEO4J_PASSWORD environment variables

find /backups -name "*.dump" | while read i; do
    dbname=$(basename $i .dump)
    echo "Starting database $dbname seeding..."
    neo4j-admin database load "$dbname" --from-path=/backups
    echo "Database seeding $dbname completed. Created databases (if not exist)"
    echo "create database \`${dbname}\` if not exists" | cypher-shell
done