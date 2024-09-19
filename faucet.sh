#!/bin/bash

# Path to the script you want to run
script_to_run="./transaction.sh"

# Run the script indefinitely
while true
do
  echo "Running script..."
  # Run the script
  $script_to_run
  
  # Wait for 10 seconds before the next run
  sleep 10
done
