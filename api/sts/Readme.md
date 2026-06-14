## Create a user with no permissions
 
We need to create a new user with no permissions and generate out access keys
```sh
aws iam create-user --user-name sts-machine-user
aws iam create-access-key --user-name sts-machine-user --output table
```

Copy the access keys and secrets here
```sh
aws configure
```
Then edit credential file to change away from default profile
```sh
open ~/.aws/credentials
```

Test who you are
```sh
aws sts get-caller-identity
aws sts get-caller-identity --profile sts
```

Make sure you don't have access to s3
```sh
aws s3 ls --profile sts
```
 
## Create a Role
 
We need to create a role that will access a new resource

```sh
chmod u+x bin/deploy
./bin/deploy
```
 
## Use new user crednetials and assum role
```sh
aws iam put-user-policy \
--user-name sts-machine-user \
--policy-name StsAssumePolicy \
--policy-document file://policy.json
```


```sh
# get the actual role ARN from the stack
ROLE_NAME=$(aws cloudformation describe-stack-resources --stack-name my-fun-stack \
  --query "StackResources[?ResourceType=='AWS::IAM::Role'].PhysicalResourceId" --output text)
ROLE_ARN="arn:aws:iam::635379700873:role/$ROLE_NAME"

# assume it as the sts user
aws sts assume-role \
--role-arn "$ROLE_ARN" \
--role-session-name s3-sts-fun \
--profile sts
```

```sh
aws sts get-caller-identity --profile assumed
```
 