plugin "aws" {
  enabled = true
  version = "0.36.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

config {
  # Check all files in subdirectories
  call_module_type = "local"
}

# Enforce all variables have descriptions
rule "terraform_documented_variables" {
  enabled = true
}

# Enforce all outputs have descriptions
rule "terraform_documented_outputs" {
  enabled = true
}

# Warn on deprecated interpolation syntax
rule "terraform_deprecated_interpolation" {
  enabled = true
}

# Ensure naming conventions are consistent
rule "terraform_naming_convention" {
  enabled = true
}