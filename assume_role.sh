#!/bin/bash

OUTPUT=$(aws sts assume-role --role-arn  arn:aws:iam::762233744920:role/Admin_Access  --role-session-name vishnu-session)
AWS_ACCESS_KEY_ID=$(echo $OUTPUT | jq -r .Credentials.AccessKeyId)
AWS_SECRET_ACCESS_KEY=$(echo $OUTPUT | jq -r .Credentials.SecretAccessKey)
AWS_SESSION_TOKEN=$(echo $OUTPUT | jq -r .Credentials.SessionToken)


rm -rf var.env

echo "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" > assume_cred.env
echo "export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> assume_cred.env
echo "export AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN" >> assume_cred.env
source assume_cred.env
