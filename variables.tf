variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Used as a prefix on all resource names"
  type        = string
  default     = "my-website"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "domain_name" {
  description = "Registered domain"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key contents for EC2 key pair"
  type        = string
}
