import json
import requests

def lambda_handler(event, context):
    response = requests.get("https://httpbin.org")
    return {
        "statusCode": 200,
        "body": json.dumps({
            "status": "Success",
            "runtime": "Docker Container",
            "origin": response.json().get("origin")
        })
    }
