# Create website 1

## Create a new bucket

```sh
aws s3api create-bucket --bucket my-fun-ar --region eu-west-1 --create-bucket-configuration LocationConstraint=eu-west-1
```

## Change block public access

```sh
aws s3api put-public-access-block \
  --bucket my-fun-ar \
  --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## Create a bucket policy

```sh
aws s3api put-bucket-policy --bucket my-fun-ar --policy file://policy.json
```

## Turn on static website hosting 

```sh
aws s3api put-bucket-website --bucket my-fun-ar --website-configuration file://website.json
```

## Upload our index.html file and include a resource that would be cross-origin

```sh
aws s3 cp index.html s3://my-fun-ar
```

## Get website url s3

```sh
http://my-fun-ar.s3-website.eu-west-1.amazonaws.com/
```

# Create website 2

## Create a new bucket

```sh
aws s3api create-bucket --bucket my-fun-ar2 --region eu-west-1 --create-bucket-configuration LocationConstraint=eu-west-1
```

## Change block public access

```sh
aws s3api put-public-access-block \
  --bucket my-fun-ar2 \
  --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## Create a bucket policy

```sh
aws s3api put-bucket-policy --bucket my-fun-ar2 --policy file://policy2.json
```

## Turn on static website hosting 

```sh
aws s3api put-bucket-website --bucket my-fun-ar2 --website-configuration file://website.json
```

## Create api Gateway with mock response

```sh
curl -X POST -H "Content-Type: application/json" https://7ja4aqwi6j.execute-api.eu-west-1.amazonaws.com/prod/hello

```

## Set CORS on our bucket 

```sh
aws s3api put-bucket-cors --bucket my-fun-ar --cors-configuration file://cors.json
```