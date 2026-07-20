#!/bin/bash

# Configuration
AWS_REGION="eu-west-1"
AWS_ACCOUNT_ID="123456789012"  # Change to your AWS Account ID
REPO_NAME="my-lambda-container-repo"
FUNCTION_NAME="my-container-lambda"
ROLE_ARN="arn:aws:iam::${AWS_ACCOUNT_ID}:role/your-lambda-execution-role"

ECR_IMAGE_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}://{REPO_NAME}:latest"

cat <<EOF > Dockerfile
FROM public.ecr.aws/lambda/python:3.11

# Install external dependencies
RUN pip install requests

# Copy the application code into the task root
COPY lambda_function.py \${LAMBDA_TASK_ROOT}

# Set the CMD to your handler
CMD [ "lambda_function.lambda_handler" ]
EOF

docker build -t $REPO_NAME .

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

aws ecr create-repository --repository-name $REPO_NAME --region $AWS_REGION 2>/dev/null || echo "Repository already exists."

docker tag ${REPO_NAME}:latest $ECR_IMAGE_URI
docker push $ECR_IMAGE_URI

rm -f Dockerfile

aws lambda update-function-code --function-name $FUNCTION_NAME --image-uri $ECR_IMAGE_URI --region $AWS_REGION 2>/dev/null

if [ $? -ne 0 ]; then
    aws lambda create-function \
        --function-name $FUNCTION_NAME \
        --package-type Image \
        --code ImageUri=$ECR_IMAGE_URI \
        --role $ROLE_ARN \
        --region $AWS_REGION
else
fi

echo "Container deployment complete."
