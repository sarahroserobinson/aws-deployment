resource "aws_db_instance" "default" {
  allocated_storage = 10
  db_name           = "awsome_db"
  engine            = "postgres"
  engine_version    = "15.4"
  instance_class    = "db.t3.micro"
  username          = "awsome_architechs"
  password          = "cloud123"
  #   parameter_group_name = "default"
  skip_final_snapshot = true
}


