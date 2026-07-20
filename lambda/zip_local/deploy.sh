#!/bin/bash

FUNCTION_NAME="my-zip-exercise"
ZIP_NAME="deployment_package.zip"
ROLE_ARN="arn:aws:iam::123456789012:role/your-lambda-execution-role"
RUNTIME="python3.11"

echo "Cleaning up old files..."
rm -f $ZIP_NAME
rm -rf package/

pip install --target ./package requests

cd package
zip -r ../$ZIP_NAME .
cd ..
zip -g $ZIP_NAME lambda_function.py

echo " Deploying to AWS Lambda..."
# Tries to update code first. If function doesn't exist, it creates it.
aws lambda update-function-code --function-name $FUNCTION_NAME --zip-file fileb://$ZIP_NAME 2>/dev/null

if [ $? -ne 0 ]; then
    echo "Creating new function..."
    aws lambda create-function \
        --function-name $FUNCTION_NAME \
        --runtime $RUNTIME \
        --role $ROLE_ARN \
        --handler lambda_function.lambda_handler \
        --zip-file fileb://$ZIP_NAME
else
    echo "Function updated successfully!"
fi

echo "Done!"
