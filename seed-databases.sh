#!/bin/bash

echo "Starting database seeding..."
neo4j-admin database load sozinianer --from-path=/backups
neo4j-admin database load regestaimperii --from-path=/backups
echo "Database seeding completed."
echo "show database" | cypher-shell
env
echo "create database \`sozinianer\` if not exists; create database \`regestaimperii\` if not exists;" | cypher-shell 