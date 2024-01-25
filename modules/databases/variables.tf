variable "rds_security_group_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "db_engine_version" {
  type = string
}

variable "db_engine" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_storage_amount" {
  type = number
}
