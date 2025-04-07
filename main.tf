locals {
  admin_user = "installer"
}
module "this_label" {
  source     = "git::github.com/xoap-io/terraform-aws-misc-label?ref=v0.1.1"
  context    = var.context
  attributes = [var.instance.engine, var.name]
}
resource "random_string" "this_snapshot" {
  length  = 5
  special = false
}
module "this_label_snapshot" {
  source     = "git::github.com/xoap-io/terraform-aws-misc-label?ref=v0.1.1"
  context    = var.context
  attributes = ["snapshot", var.instance.engine, var.name, random_string.this_snapshot.result]
}
resource "random_password" "this" {
  length = 32
}
resource "aws_db_subnet_group" "this" {
  name        = module.this_label.id
  description = "Subnet group for RDS instance ${module.this_label.id}"
  subnet_ids  = var.vpc.subnets
}
resource "aws_db_parameter_group" "this" {
  name        = module.this_label.id
  description = "Parameter group for RDS instance ${module.this_label.id}"
  family      = var.instance.family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.key
      value = parameter.value
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_db_option_group" "this" {
  name                     = module.this_label.id
  option_group_description = "Parameter group for RDS instance ${module.this_label.id}"

  engine_name          = var.instance.engine
  major_engine_version = var.instance.major_engine_version
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_db_instance" "this" {
  engine                      = var.instance.engine
  engine_version              = var.instance.engine_version
  instance_class              = var.instance.type
  identifier                  = module.this_label.id
  username                    = local.admin_user
  password                    = random_password.this.result
  skip_final_snapshot         = false
  allocated_storage           = var.storage.allocated_storage
  max_allocated_storage       = var.storage.max_allocated_storage
  storage_encrypted           = var.storage.kms_arn != ""
  kms_key_id                  = var.storage.kms_arn
  final_snapshot_identifier   = module.this_label_snapshot.id
  multi_az                    = var.instance.multi_az
  publicly_accessible         = var.instance.publicly_accessible
  deletion_protection         = var.instance.deletion_protection
  auto_minor_version_upgrade  = var.instance.allow_upgrades
  allow_major_version_upgrade = true
  db_subnet_group_name        = aws_db_subnet_group.this.id
  parameter_group_name        = aws_db_parameter_group.this.id
  option_group_name           = aws_db_option_group.this.id
  maintenance_window          = var.backup.enabled == true ? "Mon:00:00-Mon:03:00" : null
  backup_window               = var.backup.enabled == true ? "03:00-06:00" : null
  backup_retention_period     = var.backup.enabled == true ? var.backup.retention_days : 0

  vpc_security_group_ids              = var.vpc.security_groups
  performance_insights_enabled        = var.enable_performance_insights
  apply_immediately                   = true
  iam_database_authentication_enabled = true
  enabled_cloudwatch_logs_exports     = var.instance.engine == "mariadb" ? ["audit", "error", "general", "slowquery"] : var.instance.engine == "postgres" ? ["postgresql", "upgrade"] : []

  tags = {
    Name        = module.this_label.id
    Restriction = "Restricted"
  }
}
