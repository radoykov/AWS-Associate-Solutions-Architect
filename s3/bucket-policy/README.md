## Create a bucket

```sh
aws s3 mb s3://my-ar
```

## Create bucket policy 

```sh
aws s3api put-bucket-policy --bucket my-ar --policy file://policy.json
```