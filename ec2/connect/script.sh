#!/usr/bin/env bash

aws ec2-instance-connect send-ssh-public-key \
    --instance-id i-095ce99aab6171775 \
    --instance-os-user ec2-user \
    --availability-zone eu-west-1b \
    --ssh-public-key file://ec2connect.pub

ssh -i ec2connect ec2-user@108.129.167.106