variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "clh_contractors" {
  default = "clh-contractors"
}
variable "public_subnet_1" {
  default = [
    "10.0.1.0/24"
  ]
}
variable "public_subnet_2" {
  default = [
    "10.0.10.0/24"
  ]
}
variable "private_subnet_1" {
  default = [
    "10.0.20.0/24"
  ]
}
variable "private_subnet_2" {
  default = [
    "10.0.30.0/24"
  ]
}
#Instance type
variable "instance_type" {
  description = "Server"
  type        = string
  default     = "t2.micro"
}

# Ubuntu vpn host
variable "vpn_host" {
  default = "ami-04e601abe3e1a910f"
}


