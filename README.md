# ISSUES-12316

Process to reproduce the issue

```
Terraform v0.11.13
+ provider.aws v2.10.0
```

```
cd asg
terraform init
terraform workspace new testing
terraform plan
terraform apply

cd ../data

terraform init
terraform workspace new testing
terraform plan
```

actual behavior:

```
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.terraform_remote_state.fromasg: Refreshing state...

------------------------------------------------------------------------

Error: Error running plan: 3 error(s) occurred:

* data.aws_security_group.asg: 1 error(s) occurred:

* data.aws_security_group.asg: Resource 'data.terraform_remote_state.fromasg' does not have attribute 'asg' for variable 'data.terraform_remote_state.fromasg.asg'
* data.aws_security_group.asg2: 1 error(s) occurred:

* data.aws_security_group.asg2: Resource 'data.terraform_remote_state.fromasg' does not have attribute 'outputs.asg' for variable 'data.terraform_remote_state.fromasg.outputs.asg'
* data.aws_security_group.asg1: 1 error(s) occurred:

* data.aws_security_group.asg1: Resource 'data.terraform_remote_state.fromasg' does not have attribute 'output.asg' for variable 'data.terraform_remote_state.fromasg.output.asg'



```

