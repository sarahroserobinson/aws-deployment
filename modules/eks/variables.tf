variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type    = string
}

variable "cluster_version" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "node_instance_type" {
  type = string
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "desired_size" {
  type = number
}

variable "node_group_ami_type" {
  type = string
}