## Step 1: Authorize Redis Traffic in the Default Security Group

```bash
# 1. Fetch your default security group ID
DEFAULT_SG_ID=\$(aws ec2 describe-security-groups \
  --filters "Name=group-name,Values=default" \
  --query "SecurityGroups.GroupId" \
  --output text)

# 2. Authorize inbound port 6379 for the group itself
aws ec2 authorize-security-group-ingress \
  --group-id \$DEFAULT_SG_ID \
  --protocol tcp \
  --port 6379 \
  --source-group \$DEFAULT_SG_ID
```

## Step 2: Launch the EC2 Instance

```bash
aws ec2 run-instances \
  --image-id \$(aws ec2 describe-images \
    --owners 099720109477 \
    --filters "Name=name,Values=ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*" "Name=state,Values=available" \
    --query "sort_by(Images, &CreationDate)[-1].ImageId" \
    --output text) \
  --instance-type t3.micro \
  --key-name YourKeyPairName \
  --security-group-ids \$DEFAULT_SG_ID
```

## Step 3: Create the Serverless Redis Cache

```bash
aws elasticache create-serverless-cache \
  --serverless-cache-name my-cache-ab-5252 \
  --engine redis \
  --major-engine-version 7 \
  --security-group-ids \$DEFAULT_SG_ID
```

## Step 4: Retrieve the Cache Endpoint

```bash
aws elasticache describe-serverless-caches \
  --serverless-cache-name my-cache-ab-5252 \
  --query "ServerlessCaches.Endpoint.Address" \
  --output text
```

## Step 5: Install Redis Tools on EC2

SSH into your new EC2 instance and install the required client utility binaries.

```bash
ssh -i "YourKeyPairName.pem" ubuntu@your-ec2-public-ip

sudo apt update && sudo apt install -y redis-tools
```

## Step 6: Test the Connection

```bash
# Connect using the endpoint gathered in Step 4
redis-cli -h your-cache-endpoint.cache.amazonaws.com -p 6379 --tls
```
Once the interactive prompt loads, verify connectivity with the `ping` utility command:

```redis
your-cache-endpoint:6379> ping
PONG
```
