output "allow_http_security_group_id" {
  value = aws_security_group.allow_http.id
}

output "allow_https_security_group_id" {
  value = aws_security_group.allow_https.id
}

output "allow_egress_security_group_id" {
  value = aws_security_group.allow_egress.id
}

output "allow_db_security_group_id" {
  value = aws_security_group.allow_db.id
}