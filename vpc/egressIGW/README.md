## Create vpc
aws ec2 create-vpc --cidr-block 10.0.0.0/16 --amazon-provided-ipv6-cidr-block

## Create a subnet
aws ec2 create-subnet --vpc-id vpc-0cdbbd322efa33752 --ipv6-cidr-block 2a05:d018:133:a200::/56 --cidr-block 10.0.2.0/24

## Make the transition
aws ec2 modify-subnet-attribute --subnet-id subnet-02c4a44062e0f02bd --enable-dns64

## Create egress IGW
aws ec2 create-egress-only-internet-gateway --vpc-id vpc-0cdbbd322efa33752

## Create IGW
 aws ec2 create-internet-gateway

## Attach IGW to VPC
aws ec2 attach-internet-gateway --internet-gateway-id igw-0261a7ccf759f0678 --vpc-id vpc-0cdbbd322efa33752

## Create elastic IP address
aws ec2 allocate-address

## Create NAT gateway
aws ec2 create-nat-gateway --subnet-id subnet-02c4a44062e0f02bd --allocation-id eipalloc-0d6837faf93f12f98

## Create a route table
aws ec2 create-route-table --vpc-id vpc-0cdbbd322efa33752

## Create route egress
aws ec2 create-route --route-table-id rtb-08697d1c5cc9e4c5f --destination-ipv6-cidr-block ::/0 --egress-only-internet-gateway-id eigw-0557b005d1d90c5b1

## Create route nat gateway
aws ec2 create-route --route-table-id rtb-08697d1c5cc9e4c5f --destination-ipv6-cidr-block 64:ff9b::/96 --nat-gateway-id nat-091d21d7750833b6b

## Create EC2 instance 
aws ec2 run-instances \
--image-id $(aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64 --query "Parameters[0].Value" --output text) \
--instance-type t3.micro \
--count 1 \
--iam-instance-profile Name=EC2SessionManagerProfile \
--subnet-id subnet-02c4a44062e0f02bd