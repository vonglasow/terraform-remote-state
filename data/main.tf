# vim:ts=2:sw=2:tw=0:noet
provider "aws" {
	region = "eu-central-1"
	profile = "default"
}

terraform {
	backend "s3" {
		bucket = "tf-issues-12316"
		key = "data.tfstates"
		region = "eu-central-1"
		workspace_key_prefix = ""
	}
}

data "terraform_remote_state" "fromasg" {
	backend = "s3"
	workspace = "${terraform.workspace}"
	config {
		region = "eu-central-1"
		bucket = "tf-issues-12316"
		key = "asg.tfstates"
		workspace_key_prefix = ""
	}
}

# Try syntax 1
data "aws_security_group" "asg" {
	id = "${data.terraform_remote_state.fromasg.asg}"
}

# Try syntax 2
data "aws_security_group" "asg1" {
	id = "${data.terraform_remote_state.fromasg.output.asg}"
}

# Try syntax 3
data "aws_security_group" "asg2" {
	id = "${data.terraform_remote_state.fromasg.outputs.asg}"
}
