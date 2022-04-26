variable "name" {
  type        = string
  description = "The name of the RDS instance"
}
variable "vpc" {
  type = object({
    id              = string
    subnets         = list(string)
    security_groups = list(string)
  })
  description = "The VPC to create the RDS instance in"
}
variable "instance" {
  type = object({
    type                 = string
    engine               = string
    engine_version       = string
    major_engine_version = string
    family               = string
    multi_az             = bool
    publicly_accessible  = bool
    deletion_protection  = bool
    allow_upgrades       = bool
    port                 = number
  })
  description = "The RDS instance to create"
}
variable "storage" {
  type = object({
    max_allocated_storage = number
    allocated_storage     = number
    kms_arn               = string
  })
  description = "The storage configuration for the RDS instance"
}
variable "backup" {
  type = object({
    enabled        = bool
    retention_days = number
  })
  description = "The backup configuration for the RDS instance"
}
variable "logging" {
  type = object({
    enabled = bool
    types   = set(string)
  })
  description = "The logging configuration for the RDS instance"
}
variable "parameters" {
  type        = map(string)
  description = "The parameters to pass to the RDS instance"
}
variable "enable_performance_insights" {
  type        = bool
  description = "Whether to enable Performance Insights"
}
variable "context" {
  type = object({
    organization = string
    environment  = string
    account      = string
    product      = string
    tags         = map(string)
  })
  description = "Default context for naming and tagging purpose"
}
