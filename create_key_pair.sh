#!/bin/bash

# Script to create a key pair in AWS
# So that we can SSH into the Bastion Server and 'jump box' into the Web Servers in the Private Subnet

# Example command:
# ./create_key_pair.sh <key-name> <profile-name>

# After running this script, you will get a <key-name>.pem file in the current directory
# (Also, Remember to update the KeyPairName parameter in the starter/udagram-parameters.json file with your <key-name>)

# Later, we will use this <key-name>.pem file to SSH into the Bastion Server
aws ec2 create-key-pair \
    --key-name $1 \
    --query 'KeyMaterial' \
    --output text > "$1.pem" \
    --profile $2