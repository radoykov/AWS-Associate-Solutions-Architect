#!/usr/bin/env bash

echo "== deploy sns"

STACK_NAME="sns-basic"

aws cloudformation deploy \
--template-file template.yaml \
--capabilities CAPABILITY_NAMED_IAM \
--no-execute-changeset \
--region eu-west-1 \
--stack-name $STACK_NAME
