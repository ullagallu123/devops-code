#!/bin/bash

# List of directories
directories=("vpc" "sg" "ec2-machines" "rds")

# Loop through each directory
for dir in "${directories[@]}"; do
  if [ -d "$dir" ]; then
    echo "Creating resources in $dir..."
    cd "$dir"
    terraform init;terraform fmt;terraform validate;terraform apply --auto-approve
    cd ..
  else
    echo "Directory $dir does not exist."
  fi
done