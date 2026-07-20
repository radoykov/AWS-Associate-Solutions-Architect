import json
import requests

def lambda_handler(event, context):
    # Fetch data from a free public API
    res = requests.get("https://httpbin.org")
    
    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Deployment script worked perfectly!",
            "origin_ip": res.json().get("origin")
        })
    }
