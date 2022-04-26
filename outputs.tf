output "context" {
  value       = var.context
  description = "Exported context from input variable"
}
output "db_instance" {
  value       = aws_db_instance.this
  description = "Exported output from aws_db_instance"
}
output "option_group" {
  value       = aws_db_option_group.this
  description = "Exported output from aws_db_option_group"
}
output "parameter_group" {
  value       = aws_db_parameter_group.this
  description = "Exported output from aws_db_parameter_group"
}
output "subnet_group" {
  value       = aws_db_subnet_group.this
  description = "Exported output from aws_db_subnet_group"
}
output "auth" {
  value = {
    host     = aws_db_instance.this.endpoint
    port     = aws_db_instance.this.port
    username = aws_db_instance.this.username
    password = aws_db_instance.this.password
  }
  description = "Exported auth information for passing between modules"
}
