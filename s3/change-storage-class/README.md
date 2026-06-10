## Create a bucket 

aws s3 mb s3://my-fun-ar

## Create a file

echo "Hello World!" > hi.txt
aws s3 cp hi.txt s3://my-fun-ar --storage-class STANDARD_IA

## Cleanup

aws s3 rm s3://my-fun-ar/hi.txt
aws s3 rb s3://my-fun-ar