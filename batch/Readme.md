# Login to ECR

aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 635379700873.dkr.ecr.eu-west-1.amazonaws.com

# Build image

docker build -t app/sqaure .

# Create Compute Env
aws batch create-compute-environment --compute-environment-name my-compute-env \
  --type MANAGED \
  --compute-resources minvCpus=0,desiredvCpus=1,maxvCpus=1,instanceTypes=m4.16xlarge,subnets=subnet-12345678,securityGroupIds=sg-12345678 \
  --service-role arn:aws:iam::123456789012:role/service-role/AWSBatchServiceRole

# Create Queue

aws batch create-job-queue \
--job-queue-name my-job-queue \
--state ENABLED \
--priority 1 \
--compute-environment-order '[
  {
    "order": 1,
    "computeEnvironment": "arn:aws:batch:ca-central-1:982383527471:compute-environment/ComputeEnv"
  }
]'

# Register Job

aws batch register-job-definition \
    --job-definition-name square-job \
    --type container \
    --container-properties '{"image": "my-docker-image"}'

# Submit Job

aws batch submit-job \
    --job-name my-job \
    --job-definition square-job \
    --job-queue my-job-queue
