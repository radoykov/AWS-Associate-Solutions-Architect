#!/bin/bash

# Configuration
FUNCTION_NAME="my-zip-package-lambda"
ZIP_NAME="lambda_package.zip"
ROLE_ARN="arn:aws:iam::123456789012:role/your-lambda-execution-role"
RUNTIME="python3.11"
BUILD_DIR="build_out"

rm -f $ZIP_NAME
rm -rf $BUILD_DIR
mkdir $BUILD_DIR

pip install --target ./$BUILD_DIR requests

cp lambda_function.py ./$BUILD_DIR/

cd $BUILD_DIR
zip -r ../$ZIP_NAME .
cd ..

rm -rf $BUILD_DIR

aws lambda update-function-code --function-name $FUNCTION_NAME --zip-file fileb://$ZIP_NAME 2>/dev/null

if [ $? -ne 0 ]; then
    aws lambda create-function \
        --function-name $FUNCTION_NAME \
        --runtime $RUNTIME \
        --role $ROLE_ARN \
        --handler lambda_function.lambda_handler \
        --zip-file fileb://$ZIP_NAME
else
fi

echo "Deployment complete."
