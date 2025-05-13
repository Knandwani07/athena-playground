#!/bin/bash

############################################################
# Script Name: aws_s3_sample_logs.sh
# Description: List and download sample CloudFront logs 
#              from Amazon S3 for local analysis.
############################################################

# ---------------------------
# STEP 1: List CloudFront log files in the S3 bucket
# ---------------------------
aws s3 ls s3://athena-examples-ap-south-1/cloudfront/plaintext/

# ---------------------------
# STEP 2: Copy a sample log file from S3 to the local directory
# ---------------------------
aws s3 cp s3://athena-examples-ap-south-1/cloudfront/plaintext/log1 ./log1




