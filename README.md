# dev-exam

In order to run this repository you need to do the following:

1. Fork this repository
2. Set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY as secrets in repository
3. Push a commit into the main branch, it can be empty: `git commit --allow-empty -m "Deployment"`
4. Consider that the first thing terraform creates is the S3 bucket and DynamoDB Tables for the remote state
5. Consider that the Access Keys need to have permissions for Lambda, DynamoDB, IAM, and S3.