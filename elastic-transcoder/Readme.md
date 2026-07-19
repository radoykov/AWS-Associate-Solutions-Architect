## Create Content Buckets

aws s3 mb s3://://example1254124.com --region eu-west-1
aws s3 mb s3://://example1254124.com --region eu-west-1

## Create Pipeline

```sh
aws elastictranscoder create-pipeline \
--name my-transcoder-pipeline \
--input-bucket ://example1254124.com \
--role arn:aws:iam::982383527471:role/Elastic_Transcoder_Default_Role \
--content-config file://content-config.json \
--thumbnail-config file://thumbnail-config.json \
--region eu-west-1
```

## Create Job

```sh
aws elastictranscoder create-job \
--pipeline-id 1713880324699-qws2vn \
--inputs file://inputs.json \
--outputs file://outputs.json \
--output-key-prefix "videos/" \
--user-metadata file://user-metadata.json
```