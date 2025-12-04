#!/bin/bash

# Add python library paths
export PYTHONPATH="$PYTHONPATH:/var/portal/GISportal/plotting:/var/portal/GISportal/plotting/data_extractor"

# Start Redis
redis-server --daemonize yes

# Load NVM properly (installed in /var/portal/.nvm AND sourced via .bashrc)
export NVM_DIR="/var/portal/.nvm"
source "$NVM_DIR/nvm.sh"
source /var/portal/.bashrc

# Create logs directory
mkdir -p /var/portal/GISportal/logs
chmod 777 /var/portal/GISportal/logs

# Run GISportal (Node.js 10)
echo "Starting GISportal..."
nvm use 10

# keep restarting if it crashes
while true
do
    node app.js >> /var/portal/GISportal/logs/app.log 2>&1
    echo "GISportal crashed, restarting in 10 seconds..."
    sleep 10
done
