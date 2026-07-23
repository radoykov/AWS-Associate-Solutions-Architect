# Create a bucket for cloudtrail logs

aws s3 mb s3://my-cloudtrail-651468

# Create bucket policy to allow cloud trail to put to bucket
aws s3api put-bucket-policy --bucket my-cloudtrail-651468 --policy file://bucket-policy.json

# Create Trail
aws cloudtrail create-trail \
--name MyTrail \
--s3-bucket-name my-cloudtrail-651468 \
--region eu-west-1

# Start logging 
aws cloudtrail start-logging --name MyTrail
