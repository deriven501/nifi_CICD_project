output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.eks.name
}

output "eks_cluster_endpoint" {
  description = "EKS API server endpoint"
  value       = aws_eks_cluster.eks.endpoint
}

output "subnet_ids" {
  description = "Subnet IDs used by EKS"
  value       = join(",", data.aws_subnets.default.ids)
}

output "vpc_id" {
  description = "VPC ID in use"
  value       = data.aws_vpc.default.id
}

output "nifi_public_ip" {
  value = aws_launch_template.eks_nodes.public_ip
}