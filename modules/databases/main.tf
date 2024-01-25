resource "aws_db_instance" "default" {
  allocated_storage   = var.db_storage_amount
  db_name             = var.db_name
  engine              = var.db_engine
  engine_version      = var.db_engine_version
  instance_class      = var.db_instance_class
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
  publicly_accessible = true

  db_subnet_group_name = aws_db_subnet_group.default.name

}

resource "aws_db_subnet_group" "default" {
  name       = "subnet_group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "My DB subnet group"
  }
}
