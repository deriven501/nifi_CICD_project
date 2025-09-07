data "aws_ssm_parameter" "eks_al2_ami" {
  name = "/aws/service/eks/optimized-ami/${var.cluster_version}/amazon-linux-2/recommended/image_id"
}

resource "aws_launch_template" "eks_nodes" {
  name = "${var.cluster_name}-node"  
  image_id      = data.aws_ssm_parameter.eks_al2_ami.value
  instance_type = var.instance_type
  key_name      = "NiFi"

  security_group_names = aws_security_group.allow_ssh.name

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