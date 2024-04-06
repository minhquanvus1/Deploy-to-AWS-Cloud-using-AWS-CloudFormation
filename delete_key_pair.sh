#!/bin/bash

# Script to delete the Key Pair

# Example command:
# ./delete_key_pair.sh <key-name> <profile-name>
aws ec2 delete-key-pair --key-name $1 --profile $2