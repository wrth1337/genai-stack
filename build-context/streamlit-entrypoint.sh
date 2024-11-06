#!/bin/sh

# Default values for environment variables
: "${STREAMLIT_PORT:=8080}"
: "${STREAMLIT_ADDRESS:=0.0.0.0}"
: "${STREAMLIT_FILE:=loader.py}"

# Construct the command
CMD="streamlit run ${STREAMLIT_FILE} --server.port=${STREAMLIT_PORT} --server.address=${STREAMLIT_ADDRESS}"

# Execute the command
echo $CMD
exec $CMD