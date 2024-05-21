#!/bin/bash
HOSTED_ZONE_ID="Z102029611EGT6KU94A16"

id1="i-03fecd744bfa90056"
id2="i-0dc5b4df358ff058c"

# Function to start an EC2 instance and wait until it is running
start_instance() {
    local instance_id=$1
    local instance_state=$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[*].Instances[*].State.Name' --output text)
    if [ "$instance_state" == "running" ]; then
        echo "Instance $instance_id is already running."
    else
        echo "Starting instance: $instance_id"
        aws ec2 start-instances --instance-ids $instance_id
        if [ $? -ne 0 ]; then
            echo "Failed to start instance: $instance_id"
            exit 1
        fi
        aws ec2 wait instance-running --instance-ids $instance_id
        if [ $? -ne 0 ]; then
            echo "Instance did not reach running state: $instance_id"
            exit 1
        fi
    fi
}

# Function to get the public IP of an EC2 instance
get_public_ip() {
    local instance_id=$1
    local ip_address=$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)
    if [ -z "$ip_address" ]; then
        echo "Failed to get IP address for instance: $instance_id"
        exit 1
    fi
    echo $ip_address
}

# Start EC2 instances if they are not already running and get their IP addresses
instance_output=""
start_instance $id1
ip1=$(get_public_ip $id1)
instance_output+=" $id1=$ip1"

start_instance $id2
ip2=$(get_public_ip $id2)
instance_output+=" $id2=$ip2"

# Construct the JSON payload for the change-resource-record-sets command
payload=$(cat <<EOF
{
  "Changes": [
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "jenkins.ullagallubuffellomilk.store",
        "Type": "A",
        "TTL": 1,
        "ResourceRecords": [
          {
            "Value": "$ip1"
          }
        ]
      }
    },
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "jagent.ullagallubuffellomilk.store",
        "Type": "A",
        "TTL": 1,
        "ResourceRecords": [
          {
            "Value": "$ip2"
          }
        ]
      }
    }
  ]
}
EOF
)

# Print instance IDs and their respective IP addresses
echo "$instance_output"

# Update the Route 53 records
echo "Trying to update records..."
aws route53 change-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID --change-batch "$payload"
if [ $? -ne 0 ]; then
    echo "Failed to update records. Please check your configuration."
    exit 1
else
    echo "Records update was successful."
fi

# Print the updated Route 53 records
echo "Verifying Route 53 records..."
updated_records=$(aws route53 list-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID --query "ResourceRecordSets[?Type == 'A' && (Name == 'jenkins.ullagallubuffellomilk.store.' || Name == 'jagent.ullagallubuffellomilk.store.')].[Name, ResourceRecords[0].Value]" --output text)
echo "Updated records:"
echo "$updated_records"
