resource "aws_launch_template" "eks_nodes" {
  name = "${var.cluster_name}-node"  
  image_id      = var.ami_id
  instance_type = var.instance_type
   


  user_data = base64encode(<<-EOT
    #!/bin/bash
    /etc/eks/bootstrap.sh ${var.cluster_name}
  EOT
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.cluster_name}-node"
    }
  }
}