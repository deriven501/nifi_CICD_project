variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "instance_type" {
  type    = string
  default = "t2.medium"
}

variable "node_group_desired" {
  description = "Desired number of EKS worker nodes"
  type        = number
  default     = 1
}

variable "node_group_min" {
  description = "Minimum number of EKS worker nodes"
  type        = number
  default     = 1
}

variable "node_group_max" {
  description = "Maximum number of EKS worker nodes"
  type        = number
  default     = 1
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "eks-nifi"
}
variable "cluster_version" {
  description = "K8s control-plane version"
  type        = string
  default     = "1.26"
}