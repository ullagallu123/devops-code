#!/bin/bash

# List of directories
directories=("ec2-machines" "rds" "sg" "vpc")

# Loop through each directory
for dir in "${directories[@]}"; do
  if [ -d "$dir" ]; then
    echo "Destroying resources in $dir..."
    cd "$dir"
    terraform init  # Initialize the Terraform configuration
    terraform destroy --auto-approve
    cd ..
  else
    echo "Directory $dir does not exist."
  fi
done

# for dir in ec2-machines rds sg vpc; do (cd $dir && terraform init && terraform destroy --auto-approve); done

