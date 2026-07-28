#!/usr/bin/env bash

echo "== deploy asg basic =="

STACK_NAME="asg-basic"

aws cloudformation deploy \
  --template-file template.yaml \
  --capabilities CAPABILITY_NAMED_IAM \
  --no-execute-changeset \
  --region ca-central-1 \
  --stack-name $STACK_NAME
