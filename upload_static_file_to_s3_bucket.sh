#!/bin/bash

# Script to upload the static index.html file to S3 Bucket
# So that the WebServer can get the file and serve it

# Example command:
# ./upload_static_file_to_s3_bucket.sh <bucket-name> <profile-name>

aws s3api put-object \
    --bucket $1 \
    --key index.html \
    --body index.html \
    --content-type text/html \
    --profile $2