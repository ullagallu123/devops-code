#!/bin/bash

# Instance IDs
instance_ids=("i-03fecd744bfa90056" "i-0dc5b4df358ff058c")

# Function to stop an EC2 instance and wait until it is stopped
stop_instance() {
    local instance_id=$1
    echo "Stopping instance: $instance_id"
    aws ec2 stop-instances --instance-ids $instance_id
    aws ec2 wait instance-stopped --instance-ids $instance_id
    echo "Instance $instance_id has been stopped."
}

# Stop each instance and wait until it is stopped
for instance_id in "${instance_ids[@]}"; do
    stop_instance $instance_id
done

echo "All instances have been stopped."
