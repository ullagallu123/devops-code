#!/bin/bash

# Define the instance ID
instance_id="i-00ef0a3a37a1949f5"

# Function to stop an EC2 instance and wait until it is stopped
stop_instance() {
    local instance_id=$1
    echo "Stopping instance: $instance_id"
    aws ec2 stop-instances --instance-ids $instance_id
    echo "Waiting for instance $instance_id to stop..."
    aws ec2 wait instance-stopped --instance-ids $instance_id
    echo "Instance $instance_id has been stopped."
}

# Stop the instance and wait until it is stopped
stop_instance $instance_id

echo "All instances stopped successfully."
