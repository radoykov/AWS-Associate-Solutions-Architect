#!/usr/bin/env bash

echo "== deploy secrets manager stuff"

STACK_NAME="aws-sm-basic"

aws cloudformation deploy \
--template-file template.yaml \
--capabilities CAPABILITY_NAMED_IAM \
--no-execute-changeset \
--region ca-central-1 \
--stack-name $STACK_NAME
