## Create NACL

```sh
aws ec2 create-network-acl --vpc-id vpc-03181823a2da0addd
```

## Get AMI for Amazon Linux 2


Grap the latest AMI 
```sh
aws ec2 describe-images \
--owners amazon \
--filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" "Name=state,Values=available" \
--query "Images[?starts_with(Name, 'amzn2')]|sort_by(@, &CreationDate)[-1].ImageId" \
--region eu-west-1 --output text
```

## Add entry
```sh
aws ec2 create-network-acl-entry \
--network-acl-id acl-05fbbf7e37301e208 \
--ingress \
--rule-number 90 \
--protocol -1 \
--port-range From=0,To=65535 \
--cidr-block 95.111.38.170/32 \
--rule-action deny
```
