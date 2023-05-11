# Terraform_First_Project

This is Terrafom Tuto Application.

## Terraform commands
### Basic commands

```
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
terraform destroy
```

You can also save the plan in a file in order to execute it using later with "terraform apply":

```
terraform plan -out=tfplan
terraform show tfplan
terraform show -json tfplan
terraform apply -input=false tfplan
```
The -input=false flag tells Terraform to skip interactive input prompts and assume the default value for any prompts. The -auto-approve flag tells Terraform to automatically approve the changes without prompting for confirmation.

### Terraform State commands

```
terraform state list 
terraform state show <ressource_name>
terraform state rm <ressource_name>
```

### Terraform interactive CLI Command

```
terraform console
```

## Terraform variables
### Get more verbose logs:
```
export TF_LOG=TRACE
```

## Configure AWS credentials for the Terraform AWS provider

### Using Environment variables
You can set the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables in your shell or in your .bashrc or .bash_profile file. For example:

```
export AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=YOUR_SECRET_KEY
```

### Using AWS configuration file:
Alternatively, you can create an AWS configuration file under ~/.aws/credentials  with the following format:

```
[default]
aws_access_key_id = YOUR_ACCESS_KEY
aws_secret_access_key = YOUR_SECRET_KEY
```
OR you can create a named profile in the configuration file by replacing the [default] section header with a profile name:

```
[myprofile]
aws_access_key_id = YOUR_ACCESS_KEY
aws_secret_access_key = YOUR_SECRET_KEY
region = us-west-2
```

In this case, you would need to specify the profile name in your Terraform configuration file:

```
provider "aws" {
  profile = "myprofile"
  region  = "us-west-2"
}
```