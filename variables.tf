variable "region-1" {
  type        = string
  description = "aws first region of choice"
}

variable "region-2" {
  type        = string
  description = "aws second region of choice"
}

variable "ami" {
  type        = string
  description = "Region specific Amazon machine image (ami)"
}

variable "instance_type" {
  type        = string
  description = "Specify an instance type"
  default     = "t2.micro"
}

variable "project_name" {
  type        = string
  description = "Specify the project name"
}