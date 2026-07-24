import boto3

personalize_runtime = boto3.client('personalize_runtime')

campaign_arn = 'arn:aws:personalize:ca-central-1:982383527471:campaign/my-campaign'
user_id = '127'

response = personalize_runtime.get_recommendations(
    campaignArn=campaign_arn,
    userId=user_id,
)

for item in response['itemList']:
    print(f"Item ID: {item['itemId']} Score: {item.get('score', 'N/A')}")
