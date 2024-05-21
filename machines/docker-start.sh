#!/bin/bash

HOSTED_ZONE_ID="Z102029611EGT6KU94A16"

# Instance ID for ld
ld_id="i-00ef0a3a37a1949f5"

# Function to check if an instance is running and get its public IP address
get_instance_ip() {
    local instance_id=$1
    local instance_state=$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[*].Instances[*].State.Name' --output text)
    if [ "$instance_state" = "running" ]; then
        # Instance is already running, get its IP address
        local ipv4_address=$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)
        if [ -z "$ipv4_address" ]; then
            echo "Failed to get IP address for instance: $instance_id" >&2
            exit 1
        fi
        echo "$ipv4_address"
    elif [ "$instance_state" = "stopped" ]; then
        # Instance is stopped, start it and get its IP address
        echo "Starting instance: $instance_id" >&2
        aws ec2 start-instances --instance-ids $instance_id > /dev/null
        aws ec2 wait instance-running --instance-ids $instance_id
        local ipv4_address=$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)
        if [ -z "$ipv4_address" ]; then
            echo "Failed to get IP address for instance: $instance_id" >&2
            exit 1
        fi
        echo "$ipv4_address"
    else
        echo "Instance is not in a valid state: $instance_state" >&2
        exit 1
    fi
}

# Get the ld instance IP address
ld_ip=$(get_instance_ip $ld_id)

# Construct the JSON payload for change-resource-record-sets command
payload=$(cat <<EOF
{
  "Changes": [
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "ld.ullagallubuffellomilk.store",
        "Type": "A",
        "TTL": 1,
        "ResourceRecords": [
          {
            "Value": "$ld_ip"
          }
        ]
      }
    }
  ]
}
EOF
)

# Print instance ID and its respective IP address
echo "ld_id=$ld_ip"

echo "Trying to update records..."
# Update the Route 53 record
if aws route53 change-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID --change-batch "$payload"; then
    echo "Records update was successful."
else
    echo "Failed to update records. Please check your configuration."
    exit 1
fi

# Verify the updated Route 53 record
echo "Verifying Route 53 records..."
updated_records=$(aws route53 list-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID --query "ResourceRecordSets[?Type == 'A' && Name == 'ld.ullagallubuffellomilk.store.'].[Name, ResourceRecords[0].Value]" --output text)
echo "Updated records:"
echo "$updated_records"
