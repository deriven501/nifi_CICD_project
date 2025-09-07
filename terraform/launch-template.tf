data "aws_ssm_parameter" "eks_al2_ami" {
  name = "/aws/service/eks/optimized-ami/${var.cluster_version}/amazon-linux-2/recommended/image_id"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH and HTTPS(8443) inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS 8443"
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "NiFi UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_template" "eks_nodes" {
  name = "${var.cluster_name}-node"  
  image_id      = data.aws_ssm_parameter.eks_al2_ami.value
  instance_type = var.instance_type
  key_name      = "NiFi"

  security_group_names = aws.aws_security_group.allow_ssh.name
  
  user_data = base64encode(<<-EOT
    #!/bin/bash
    /etc/eks/bootstrap.sh ${var.cluster_name}
  EOT
  )
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.cluster_name}-node",
    }


  }

  
}