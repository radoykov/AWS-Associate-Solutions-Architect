#!/usr/bin/env bash

echo "== deploy rds"

STACK_NAME="rds-basic"

# Define your infrastructure variables below (Replace with your actual AWS IDs)
VpcId="vpc-0123456789abcdef0"
WebServerSGGroupId="sg-0123456789abcdef0"
Username="dbadmin"
Subnets="subnet-0123456,subnet-0654321" # Must provide at least two subnets in different AZs

# https://amazonaws.com
aws cloudformation deploy \
--template-file template.yaml \
--capabilities CAPABILITY_NAMED_IAM \
--region eu-west-1 \
--stack-name $STACK_NAME \
--parameter-overrides \
VpcId="$VpcId" \
WebServerSGGroupId="$WebServerSGGroupId" \
Username="$Username" \
Subnets="$Subnets"
