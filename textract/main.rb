require 'aws-sdk-textract'

client = Aws::Textract::Client.new region: 'eu-west-1'
bucket = 'textract-exp-5648'
name = 'image.png'
resp = client.analyze_document({
  document: { # required
    bytes: "data",
    s3_object: {
      bucket: bucket,
      name: name,
      #version: "S3ObjectVersion",
    },
  },
  # required, accepts TABLES, FORMS, QUERIES, SIGNATURES, LAYOUT
  feature_types: ["TABLES"]
})
