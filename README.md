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

### Terraform Recreate and import ressources

Terraform usually only updates your infrastructure if it does not match your configuration. You can use the -replace flag for terraform plan and terraform apply operations to safely recreate resources in your environment even if you have not edited the configuration
```
terraform plan -replace="aws_instance.example"
terraform apply -replace="aws_instance.example"
```

In older versions of Terraform, you may have used the terraform taint command to achieve a similar outcome. That command has now been deprecated in favor of the -replace flag
In older versions you can use "taint" cmd to tell terraform that you want recreate this ressource in the next "apply".

```
terraform taint <ressource_address>
terraform taint aws_instance.terraform_vm
```

You can use "import" command to import an external ressource by its ID and bind it to a ressource object declared in your terraform configuration files.

```
terraform import <ressource_address> <unmanaged-resource-id>
terraform import aws_instance.webserver2 i-0ccb8fb34380b0ee7
```
### Terraform State commands

```
terraform state list 
terraform state show <ressource_name>
terraform state rm <ressource_name>
terraform state mv -state-out=<path-of-destination-state-file> <ressource_name> <ressource_new_name>
```
The **terraform state mv** command moves resources from one state file to another. You can also rename resources with **mv**. The move command will update the resource in state, but not in your configuration file. Moving resources is useful when you want to combine modules or resources from other states, but do not want to destroy and recreate the infrastructure.

### Terraform Workspace commands

```
terraform workspace new <workspace_name>
terraform workspace list
terraform workspace select <workspace_name>
terraform workspace show
terraform workspace delete <workspace_name>
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
You can set the following levels: TRACE, DEBUG, INFO, ERROR
but TRACE is the most verbose level logging and the most reliable one.

To redirect logs and save it in a file, you can use **TF_LOG_PATH** environment variable.
```
export TF_LOG_PATH=./terraform.log
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
