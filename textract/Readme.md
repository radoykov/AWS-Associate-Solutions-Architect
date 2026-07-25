# Create s3 bucket 
aws s3 mb s3://textract-exp-5648 --region eu-west-1

# Insert image into s3 bucket
aws s3 cp image.png s3://textract-exp-5648
