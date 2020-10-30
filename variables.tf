variable "region" {
  default = "ap-southeast-2"
}

variable "ami_id" {
  default = "ami-a0360bc3"
}

variable "instance_class" {
  default = "t2.micro"
}

variable "key_name" {
  description = "SSH key name to launch instances with"
}

