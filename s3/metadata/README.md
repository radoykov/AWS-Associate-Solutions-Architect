## Create a bucket 

aws s3 mb s3://my-meta-fun

## Create a new file

echo "hello Mars" > hi.txt

## Uploadfile with metadata

aws s3api put-object --bucket my-meta-fun --key hi.txt --body hi.txt --metadata Planet=Mars

## Get metadata throgh head object

aws s3api head-object --bucket my-meta-fun --key hi.txt