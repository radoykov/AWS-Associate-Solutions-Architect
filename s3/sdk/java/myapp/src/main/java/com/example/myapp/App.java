package com.example.myapp;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.CreateBucketRequest;
import software.amazon.awssdk.services.s3.model.S3Exception;

/**
 * Start point for lambda function..
 */
public class App implements RequestHandler<Object, String> {
    private final S3Client s3Client;

    public App() {
        this.s3Client = DependencyFactory.s3Client();
    }

    @Override
    public String handleRequest(final Object input, final Context context) {
        String bucketName = input.toString().trim();
        
        context.getLogger().log("Try creating S3 bucket: " + bucketName);

        try {
            CreateBucketRequest createBucketRequest = CreateBucketRequest.builder()
                    .bucket(bucketName)
                    .build();

            // Invoke AWS S3 API
            s3Client.createBucket(createBucketRequest);
            
            String successMessage = "Success S3 bucket: " + bucketName;
            context.getLogger().log(successMessage);
            return successMessage;

        } catch (S3Exception e) {
            context.getLogger().log("Error from S3 API: " + e.awsErrorDetails().errorMessage());
            return "Error why making a bucket: " + e.getMessage();
        } catch (Exception e) {
            context.getLogger().log("System error: " + e.getMessage());
            return "Unsuccessful operation: " + e.getMessage();
        }
    }
}
