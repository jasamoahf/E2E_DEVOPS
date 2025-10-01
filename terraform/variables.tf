variable "project" {
  type    = string
  default = "e2e-devops"
}
variable "env" {
  type    = string
  default = "dev"
}
variable "region" {
  type    = string
  default = "us-east-1"
}

variable "container_image_tag" {
  description = "Image tag to deploy (e.g., Jenkins build number or 'latest')"
  type        = string
  default     = "latest"
}

variable "container_port" {
  type    = number
  default = 5000
}
variable "desired_count" {
  type    = number
  default = 1
}

variable "cpu" {
  type    = number
  default = 256
}

variable "memory" {
  type    = number
  default = 512
}

variable "tags" {
  type    = map(string)
  default = {}
}
