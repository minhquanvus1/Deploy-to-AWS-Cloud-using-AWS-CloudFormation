# CD12352 - Infrastructure as Code Project Solution

# Tran Nguyen Minh Quan

## Spin up instructions

1. Set up the AWS CLI:

   - Install the AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html
   - Configure the AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html

2. Clone this GitRepo:

3. Create the Network Stack:
   `./run.sh deploy YOUR_AWS_REGION YOUR_NETWORK_STACK_NAME starter/network.yml starter/network-parameters.json YOUR_AWS_PROFILE`

4. Create the Application Stack:
   Change the S3BucketName variable value in the `starter/udagram-parameters.json` file to a unique name.
   Comment out the command relating to get index.html file from S3 Bucket, and uncomment the 'cat EOF' command in the UserData property of the WebServerLaunchTemplate resource in the `starter/udagram.yml` file.s
   then, run: `./run.sh deploy YOUR_AWS_REGION YOUR_APP_STACK_NAME starter/udagram.yml starter/udagram-parameters.json YOUR_AWS_PROFILE`

5. Upload the index.html file to the S3Bucket:
   `aws s3api put-object --bucket YOUR_S3_BUCKET_NAME --key index.html --body index.html --content-type text/html --profile YOUR_AWS_PROFILE`

6. Comment out the 'cat EOF' command in the UserData property of the WebServerLaunchTemplate resource in the `starter/udagram.yml` file, and uncomment the command relating to get index.html file from S3 Bucket. Then, update the Application Stack:
   `./run.sh deploy YOUR_AWS_REGION YOUR_APP_STACK_NAME starter/udagram.yml starter/udagram-parameters.json YOUR_AWS_PROFILE`. Then, terminate the EC2 Instances so that the new UserData script can be executed.

7. Access the Application Load Balancer DNS Name to see the result.

## Tear down instructions

1. Empty the S3Bucket
2. Delete the Application Stack:
   `./run.sh delete YOUR_AWS_REGION YOUR_APP_STACK_NAME YOUR_AWS_PROFILE`
3. Delete the Network Stack:
   `./run.sh delete YOUR_AWS_REGION YOUR_NETWORK_STACK_NAME YOUR_AWS_PROFILE`

## Other considerations

- This is the DNS Name for the Application Load Balanncer: `http://myudag-loadb-9jlnpxl4b1ir-1039294898.us-east-2.elb.amazonaws.com/`
