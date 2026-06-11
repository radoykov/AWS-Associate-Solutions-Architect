## Create a new bucket

```sh
aws s3api create-bucket --bucket my-fun-ar --region eu-west-1 --create-bucket-configuration LocationConstraint=eu-west-1
```

## Turn of Block Puplic Access for ACLs

```sh
aws s3api put-public-access-block \
--bucket my-fun-ar \
--public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=true,RestrictPublicBuckets=true"
```

```sh
aws s3api get-public-access-block --bucket my-fun-ar
```

## Change bucket ownership

```sh
aws s3api put-bucket-ownership-controls \
--bucket my-fun-ar \
--ownership-controls="Rules=[{ObjectOwnership=BucketOwnerPreferred}]"
```

## Change ACLs to allow user from another aws account 

```sh
aws s3api put-bucket-acl \
--bucket my-fun-bucket \
--access-control-policy file://policy.xml
```