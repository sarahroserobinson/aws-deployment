resource "aws_db_instance" "default" {
  allocated_storage = 10
  db_name           = "awsome_db"
  engine            = "postgres"
  engine_version    = "15.4"
  instance_class    = "db.t3.micro"
  username          = "postgres"
  password          = "cloud123"
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
