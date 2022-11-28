function aws-assume-role
    set -e AWS_ACCESS_KEY_ID
    set -e AWS_SECRET_ACCESS_KEY
    set -e AWS_SESSION_TOKEN
    set CREDS (aws sts assume-role --role-arn $argv[1] --role-session-name aws-assume-role)
    set -gx AWS_ACCESS_KEY_ID (echo $CREDS | jq -r '.Credentials.AccessKeyId')
    set -gx AWS_SECRET_ACCESS_KEY (echo $CREDS | jq -r '.Credentials.SecretAccessKey')
    set -gx AWS_SESSION_TOKEN (echo $CREDS | jq -r '.Credentials.SessionToken')
end
