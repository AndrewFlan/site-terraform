# About

This repository stores the Terraform code to manage the AWS Infrastructure for my Personal Website [andrewflanigan.com](andrewflanigan.com)

## What is does

Terraform performs theses tasks:

- Sets up an EC2 Instance:
  - Runs the latest Ubuntu 24.04 LTS Image
  - Sets up Elastic IP, SSH keypair, enforces IMDSv2
- Sets up Security Groups:
  - Allows SSH Ingress (SSH is restrict to approved keys only)
  - Allows HTTP/HTTPS Ingress
  - Allows outbound traffic
- Sets up Route53 DNS Records for:
  - [andrewflanigan.com](andrewflanigan.com)
  - [www.andrewflanigan.com](www.andrewflanigan.com)
- Stores Terraform State in an S3 Bucket
- Keeps Terraform State lock in DynamoDB

## Github Workflows/Actions

This repository also has a couple GitHub Workflow/Actions setup:

- Runs [tflint](https://github.com/terraform-linters/tflint) on pull requests/merges
- Runs [Dependabot](https://docs.github.com/en/code-security/tutorials/secure-your-dependencies/dependabot-quickstart-guide) weekly
- Runs Terraform Init and Plan on pull requests and Apply when merged.
  - Keeps everything in GitHub making it easy to update Infrastructure
  - This Action utilizes an AWS IAM Role that authenticates via an OpenID Connect Identity Provider. The Role has a Policy that only gives it access to what Terraform needs to run. Sessions are only good for 1 hour.

## Updating the Instance AMI

Finding the AMI:

```bash
aws ec2 describe-images \
  --profile personal-site \
  --owners 099720109477 \
  --filters "Name=name,Values=ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*" \
  --query "sort_by(Images, &CreationDate)[-1].ImageId" \
  --output text
```

Force Replace instance:

```bash
AWS_PROFILE=personal-site terraform apply \
  -replace="aws_instance.web" \
  -var="ssh_public_key=$(cat ~/.ssh/my-website.pub)" \
  -var="domain_name=andrewflanigan.com"
```

Run Ansible after new Instance created:

```bash
ansible-playbook playbook.yml --extra-vars "@vars.yml"
```
