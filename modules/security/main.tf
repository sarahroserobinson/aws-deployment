resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "http"
  }
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_http.id
}

resource "aws_security_group_rule" "allow_3000" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_http.id
}


resource "aws_security_group" "allow_https" {
  name        = "allow_https"
  description = "Allow https inbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "HTTPS"
  }
}

resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_https.id
}

resource "aws_security_group" "allow_egress" {
  name        = "allow_egress"
  description = "Allow egress traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Egress"
  }
}

resource "aws_security_group_rule" "allow_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_egress.id
}



resource "aws_security_group" "allow_db" {
  name        = "allow_db"
  description = "Allow database traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "DB"
  }
}

resource "aws_security_group_rule" "allow_db" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_db.id
}
