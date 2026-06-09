package com.example.myapp;

import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.CreateBucketRequest;
import software.amazon.awssdk.services.s3.model.S3Exception;

public class App {

    public static void main(String[] args) {

        if (args.length != 1) {
            System.out.println("Usage: java App <bucket-name>");
            System.exit(1);
        }

        String bucketName = args[0];

        try (S3Client s3Client = DependencyFactory.s3Client()) {

            CreateBucketRequest request = CreateBucketRequest.builder()
                    .bucket(bucketName)
                    .build();

            s3Client.createBucket(request);

            System.out.println("Bucket created successfully: " + bucketName);

        } catch (S3Exception e) {
            System.err.println("S3 Error: " +
                    e.awsErrorDetails().errorMessage());
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
    }
}