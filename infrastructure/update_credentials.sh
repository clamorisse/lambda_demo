echo "AWS_ACCOUNT_ID=$(aws sts get-caller-identity --output text --query 'Account' --profile $2)" > build-$1.env
echo "AWS_REGION=$(aws configure get region --profile $2)" >> build-$1.env
echo "AWS_DEFAULT_REGION=$(aws configure get region --profile $2)" >> build-$1.env
echo "AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id --profile $2)" >> build-$1.env
echo "AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key --profile $2)" >> build-$1.env

