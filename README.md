# CD12352 - Infrastructure as Code Project Solution

# Tran Nguyen Minh Quan

## Introduction

- In this Project, I have learned to provision/create AWS Resources, including Networking Resources, and Application Resources using AWS CloudFormation, which is an Infrastructure as Code tool.

- This Project is about create a private network on AWS, deploy the simple index.html file to be served as a Web Server by using NginX, and expose the Web endpoint via an Application Load Balancer.

## Project Structure

- `starter/`: Contains the sub-folders corresponding to the Infrastructure Components
  - `Network/`:
    - `network-parameters.json`: Contains the parameters for the Network Stack
    - `network.yml`: Contains the CloudFormation template for the Network Stack
  - `Application/`:
    - `udagram-parameters.json`: Contains the parameters for the Application Stack
    - `udagram.yml`: Contains the CloudFormation template for the Application Stack
  - `S3/`:
    - `s3-parameters.json`: Contains the parameters for the S3 Stack
    - `s3.yml`: Contains the CloudFormation template for the S3 Stack
  - `README.md`: The Readmefile for the project
- `AWS_CloudFormation_Deploy_Web_app.drawio.png`: The diagram of the Infrastructure Components
- `screenshots/`: Contains the screenshots of the infrastructure, and SSH into the Bastion Server and Web Server
- `index.html`: The simple HTML file to be served as the Web Server
- `run.sh`: The script to deploy the CloudFormation Stack
- `create_key_pair.sh`: The script to create a Key Pair
- `delete_key_pair.sh`: The script to delete a Key Pair
- `empty_s3_bucket.sh`: The script to empty the S3 Bucket
- `upload_static_file_to_s3_bucket.sh`: The script to upload the index.html file to the S3 Bucket

## Getting Started

### Pre-requisites and Local Development

- In order to deploy the entire infrastructure to AWS, we need to install AWSCLIv2 and configure it with the AWS Account credentials. Here are the links to the instructions on how to set up AWSCLIv2:
  - Install the AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html
  - Configure the AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html
- In short, the setting up AWSCLIv2 can be done by:
  - Log in to your AWS account
  - Create an IAM User with AdministratorAccess permission, and download the Access Key ID and Secret Access Key
  - Run the `aws configure --profile YOUR_PROFILE_NAME` command in the terminal, and input the Access Key ID, Secret Access Key, Default region name, and Default output format (Notice that: we can set the `profile` for these credentials so that we can switch between different AWS accounts easily)

### Spin up instructions

- Follow these steps to spin up the infrastructure on AWS:

1. Set up the AWSCLIv2 and configure it with the AWS Account credentials (as mentioned in the Pre-requisites and Local Development section).

2. Create the Network Stack:

   ```bash
   ./run.sh deploy YOUR_AWS_REGION YOUR_NETWORK_STACK_NAME starter/Network/network.yml starter/Network/network-parameters.json YOUR_AWS_PROFILE
   ```

3. Create the S3 Bucket:

   - First, we need to update the value of the `S3BucketName` parameter in the `s3-parameters.json` file to a unique name.
   - Then, run the following command to create the S3 Bucket:

   ```bash
   ./run.sh deploy YOUR_AWS_REGION YOUR_S3_BUCKET_Stack_Name starter/S3/s3.yml starter/S3/s3-parameters.json YOUR_AWS_PROFILE
   ```

4. Upload the index.html file to the S3 Bucket

   ```bash
   # In the Project Root Folder:
   ./upload_static_file_to_s3_bucket.sh <bucket-name> <profile-name>
   ```

5. Create the Key Pair for the Bastion Server

   - Update the value of the `KeyPairName` parameter in the `Application/udagram-parameters.json` file to a unique name.
   - Then, run the following command to create the Key Pair:

   ```bash
   # In the Project Root Folder:
   ./create_key_pair.sh <key-name> <profile-name>
   ```

6. Create the Application Stack:

   ```bash
   ./run.sh deploy YOUR_AWS_REGION YOUR_APP_STACK_NAME starter/Application/udagram.yml starter/Application/udagram-parameters.json YOUR_AWS_PROFILE
   ```

7. Access the Application Load Balancer DNS Name (we can find the DNS Name URL in the `Outputs` section of the Application Stack in the AWS CloudFormation Web UI) to see the result.

### Tear down instructions

1. Empty the S3Bucket:

   ```bash
   # In the Project Root Folder:
   ./empty_s3_bucket.sh <bucket-name> <profile-name>
   ```

2. Delete the S3 Stack:
   ```bash
   ./run.sh delete YOUR_AWS_REGION YOUR_S3_BUCKET_Stack_Name YOUR_AWS_PROFILE
   ```
3. Delete the Application Stack:
   ```bash
   ./run.sh delete YOUR_AWS_REGION YOUR_APP_STACK_NAME YOUR_AWS_PROFILE
   ```
4. Delete the Network Stack:

   ```bash
   ./run.sh delete YOUR_AWS_REGION YOUR_NETWORK_STACK_NAME YOUR_AWS_PROFILE
   ```

5. Delete the Key Pair:

   ```bash
   # In the Project Root Folder:
   ./delete_key_pair.sh <key-name> <profile-name>
   ```

## How to SSH into Bastion Server and 'Jump Box' into Web Servers in Private Subnet

- First, we need to SSH into the Bastion Server (from our local network) by using the `<key_name>.pem` file that we generated earlier in the `create_key_pair.sh` script.

  ```bash
  # Set the permission for the key file to 600 to avoid the 'Permissions too open' error
  chmod 600 <key_name>.pem

  # Start the SSH Agent
  eval $(ssh-agent)

  # Add the key to the SSH Agent (this can help avoid the 'Permission denied (publickey)' error when SSH into the Bastion Server)
  ssh-add ./<key_name>.pem

  # SSH into the Bastion Server
  ssh -A -i ./<key_name>.pem ubuntu@3.137.37.106
  ```

- Then, from the Bastion Server, we can access any of the Web Server in the Private Subnet via SSH tunneling:

  ```bash
  # From the Bastion Server, SSH into the Web Server in the Private Subnet
  ssh ubuntu@[Web_Server_Private_IP]
  ```

- To exit the SSH session, we can simply type `exit` in the terminal.

## Deployment

- This is the DNS Name for the Application Load Balancer: `http://myudag-loadb-9jlnpxl4b1ir-1039294898.us-east-2.elb.amazonaws.com/`

## Author:

Quan Tran

## Acknowledgements

Thanks to the fantastic team at Udacity for their excellent Cloud DevOps Nanodegree Program that provides me the necessary knowledge to implement this project.
