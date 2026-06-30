## Convert to json

The command 
```sh
yq -o json policy.yaml > policy.json
```

The bash script 
```sh
./convert
```
## Create IAM policy
aws iam create-policy \
--policy-name my-fun-policy \
--policy-document file://policy.json

## Attach policy to user
aws iam attach-user-policy \
--policy-arn arn:aws:iam::635379700873:policy/my-fun-policy \
--user-name X

## Deleting policies
aws iam delete-policy-version \
  --policy-arn arn:aws:iam::123456789012:policy/my-fun-policy \
  --version-id v2
