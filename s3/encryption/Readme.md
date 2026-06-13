## Create a bucket 

aws s3 mb s3://my-ar

## Create a file

echo "Hello World!" > file.txt
aws s3 cp file.txt s3://my-ar

## Put object with enryption of SS3-KMS

aws s3api put-object \
--bucket my-ar \
--key aws_file.txt \
--body file.txt \
--server-side-encryption aws:kms \
--ssekms-key-id bbb578d3-7081-4634-9c14-31a844ae19c4 

### Put object with SSE-C

export BASE64_ENCODED_KEY=$(openssl rand 32 | base64)
echo BASE64_ENCODED_KEY

export MD5_VALUE=$(echo -n "$BASE64_ENCODED_KEY" | base64 --decode | openssl dgst -md5 -binary | base64)
echo MD5_VALUE

aws s3api put-object \
--bucket my-ar \
--key aws_file.txt \
--body my.txt \
--sse-customer-algorithm AES256 \
--sse-customer-key $BASE64_ENCODED_KEY \
--sse-customer-key-md5 $MD5_VALUE

## Download file

# Download file using the environment variable

aws s3api get-object \
  --bucket my-ar \
  --key aws_file.txt \
  --sse-customer-algorithm AES256 \
  --sse-customer-key "$BASE64_ENCODED_KEY" \
  --sse-customer-key-md5 "$MD5_VALUE" \
  text.txt