#!/bin/bash

set -e

STACK_NAME="memorydb-stack"
REGION="eu-west-1"

aws cloudformation deploy \
  --stack-name "$STACK_NAME" \
  --template-file template.yml \
  --region "$REGION" \
  --capabilities CAPABILITY_NAMED_IAM


aws cloudformation describe-stacks \
  --stack-name "$STACK_NAME" \
  --region "$REGION" \
  --query "Stacks[0].Outputs[?OutputKey=='ClusterEndpoint'].OutputValue" \
  --output text
