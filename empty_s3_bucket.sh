#!/bin/bash

# Script to empty an S3 Bucket
# So that we can delete the the S3 Bucket and the CloudFormation Stack that creates it

# Example command:
# ./empty_s3_bucket.sh <bucket-name> <profile-name>
aws s3 rm s3://$1 --recursive --profile $2