[![Maintained](https://img.shields.io/badge/Maintained%20by-XOAP-success)](https://xoap.io)
[![Terraform](https://img.shields.io/badge/Terraform-%3E%3D1.1.6-blue)](https://terraform.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# Table of Contents

- [Introduction](#introduction)
- [Guidelines](#guidelines)
- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules)
- [Resources](#resources)
- [Inputs](#inputs)
- [Outputs](#outputs)

---

## Introduction

This is a template for Terraform modules.

It is part of our XOAP Automation Forces Open Source community library to give you a quick start into Infrastructure as Code deployments with Terraform.

We have a lot of Terraform modules that are Open Source and maintained by the XOAP staff.

Please check the links for more info, including usage information and full documentation:

- [XOAP Website](https://xoap.io)
- [XOAP Documentation](https://docs.xoap.io)
- [Twitter](https://twitter.com/xoap_io)
- [LinkedIn](https://www.linkedin.com/company/xoap_io)

---

## Guidelines

We are using the following guidelines to write code and make it easier for everyone to follow a destinctive guideline. Please check these links before starting to work on changes.

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

Git Naming Conventions are an important part of the development process. They descrtibe how Branched, Commit Messages, Pull Requests and Tags should look like to make the easily understandebla for everybody in the development chain.

[Git Naming Conventions](https://namingconvention.org/git/)

he Conventional Commits specification is a lightweight convention on top of commit messages. It provides an easy set of rules for creating an explicit commit history; which makes it easier to write automated tools on top of.

[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)

The better a Pull Request description is, the better a review can understand and decide on how to review the changes. This improves implementation speed and reduces communication between the requester and the reviewer resulting in much less overhead.

[Wiriting A Great Pull Request Description](https://www.pullrequest.com/blog/writing-a-great-pull-request-description/)

Versioning is a crucial part for Terraform Stacks and Modules. Without version tags you cannot clearly create a stable environment and be sure that your latest changes won't crash your production environment (sure it still can happen, but we are trying our best to implement everything that we can to reduce the risk)

[Semantic Versioning](https://semver.org)

Naming Conventions for Terraform resources must be used.

[Terraform Naming Conventions](https://www.terraform-best-practices.com/naming)

---

## Usage

### Installation

For the first ime using this template necessary tools need to be installed.
A script for PowerShell Core is provided under ./build/init.ps1

This script will install following dependencies:

- [pre-commit](https://github.com/pre-commit/pre-commit)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)
- [tflint](https://github.com/terraform-linters/tflint)
- [tfsec](https://github.com/aquasecurity/tfsec)
- [checkov](https://github.com/bridgecrewio/checkov)
- [terrascan](https://github.com/accurics/terrascan)
- [kics](https://github.com/Checkmarx/kics)

This script configures:

- global git template under ~/.git-template
- global pre-commit hooks for prepare-commit-msg and commit-msg under ~/.git-template/hooks
- github actions:
  - linting and checks for pull requests from dev to master/main
  - automatic tagging and release creation on pushes to master/main
  - dependabot updates

It currently supports the automated installation for macOS. Support for Windows and Linux will be available soon.

### Synchronisation

We provided a script under ./build/sync_template.ps1 to fetch the latest changes from this template repository.
Please be aware that this is mainly a copy operation which means all your current changes have to be committed first and after running the script you have to merge this changes into your codebase.

### Configuration

---

<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.8.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this_label"></a> [this\_label](#module\_this\_label) | git::github.com/xoap-io/terraform-aws-misc-label | v0.1.0 |
| <a name="module_this_label_snapshot"></a> [this\_label\_snapshot](#module\_this\_label\_snapshot) | git::github.com/xoap-io/terraform-aws-misc-label | v0.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_option_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_option_group) | resource |
| [aws_db_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.this_snapshot](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup"></a> [backup](#input\_backup) | The backup configuration for the RDS instance | <pre>object({<br>    enabled        = bool<br>    retention_days = number<br>  })</pre> | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | Default context for naming and tagging purpose | <pre>object({<br>    organization = string<br>    environment  = string<br>    account      = string<br>    product      = string<br>    tags         = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_enable_performance_insights"></a> [enable\_performance\_insights](#input\_enable\_performance\_insights) | Whether to enable Performance Insights | `bool` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | The RDS instance to create | <pre>object({<br>    type                 = string<br>    engine               = string<br>    engine_version       = string<br>    major_engine_version = string<br>    family               = string<br>    multi_az             = bool<br>    publicly_accessible  = bool<br>    deletion_protection  = bool<br>    allow_upgrades       = bool<br>    port                 = number<br>  })</pre> | n/a | yes |
| <a name="input_logging"></a> [logging](#input\_logging) | The logging configuration for the RDS instance | <pre>object({<br>    enabled = bool<br>    types   = set(string)<br>  })</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the RDS instance | `string` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | The parameters to pass to the RDS instance | `map(string)` | n/a | yes |
| <a name="input_storage"></a> [storage](#input\_storage) | The storage configuration for the RDS instance | <pre>object({<br>    max_allocated_storage = number<br>    allocated_storage     = number<br>    kms_arn               = string<br>  })</pre> | n/a | yes |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | The VPC to create the RDS instance in | <pre>object({<br>    id              = string<br>    subnets         = list(string)<br>    security_groups = list(string)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_auth"></a> [auth](#output\_auth) | Exported auth information for passing between modules |
| <a name="output_context"></a> [context](#output\_context) | Exported context from input variable |
| <a name="output_db_instance"></a> [db\_instance](#output\_db\_instance) | Exported output from aws\_db\_instance |
| <a name="output_option_group"></a> [option\_group](#output\_option\_group) | Exported output from aws\_db\_option\_group |
| <a name="output_parameter_group"></a> [parameter\_group](#output\_parameter\_group) | Exported output from aws\_db\_parameter\_group |
| <a name="output_subnet_group"></a> [subnet\_group](#output\_subnet\_group) | Exported output from aws\_db\_subnet\_group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-disable -->
<!-- prettier-ignore-end -->
