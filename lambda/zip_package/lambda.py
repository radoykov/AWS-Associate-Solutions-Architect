import json
import requests

def lambda_handler(event, context):
    response = requests.get("https://httpbin.org")
    return {
        "statusCode": 200,
        "body": json.dumps({
            "status": "Success",
            "package": "Zip bundle created dynamically",
            "origin": response.json().get("origin")
        })
    }
