# vim:ts=2:sw=2:tw=0:noet
provider "aws" {
	region = "eu-central-1"
	profile = "default"
}

terraform {
	backend "s3" {
		bucket = "tf-issues-12316"
		key = "asg.tfstates"
		region = "eu-central-1"
		workspace_key_prefix = ""
	}
}

resource "aws_security_group" "secure" {
	name        = "issue-12316-sg"
	description = "sg"
	vpc_id      = "default"

	ingress {
		from_port   = 80
		to_port     = 80
		description = "Allow traffic from outside only on port 80"
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port   = 0
		to_port     = 0
		description = "Allow all outgoing traffic"
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

output "asg" {
	value = "${aws_security_group.secure.id}"
}
