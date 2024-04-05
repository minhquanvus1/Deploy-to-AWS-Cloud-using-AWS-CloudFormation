#!/bin/bash

EXECUTION_MODE=$1
REGION="${2:-us-east-2}"
STACK_NAME=$3
TEMPLATE_FILE_NAME=$4
PARAMETERS_FILE_NAME=$5
PROFILE="${6:-default}"

if [[ $EXECUTION_MODE != "deploy" && $EXECUTION_MODE != "delete" && $EXECUTION_MODE != "preview" ]]; then
    echo "Invalid execution mode. Please use 'deploy', 'preview', or 'delete'."
    exit 1
fi

if [ $EXECUTION_MODE == "deploy" ]; then
    command="aws cloudformation deploy \
        --stack-name $STACK_NAME \
        --template-file $TEMPLATE_FILE_NAME \
        --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
        --region $REGION \
        --profile $PROFILE"
    
    if [ -n "$PARAMETERS_FILE_NAME" ]; then
        command+=" --parameter-overrides file://$PARAMETERS_FILE_NAME"
    fi
    
    eval "$command"
fi

if [ $EXECUTION_MODE == "delete" ]
then
    aws cloudformation delete-stack \
        --stack-name $STACK_NAME \
        --region $REGION \
        --profile $PROFILE
fi

if [ $EXECUTION_MODE == "preview" ]
then
    aws cloudformation deploy \
        --stack-name $STACK_NAME \
        --template-file $TEMPLATE_FILE_NAME \
        --parameter-overrides file://$PARAMETERS_FILE_NAME \
        --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
        --no-execute-changeset \
        --region $REGION \
        --profile $PROFILE
fi