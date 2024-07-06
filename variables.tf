variable "region" {
  default = "eu-west-2"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidrs" {
    default = ["10.0.1.0/24", "10.0.2.0/24"]
# "10.0.3.0/24", "10.0.4.0/24"]
}


variable "domain_name" {
  description = "Your domain name"
  default     = "rekeyole.com"
}

