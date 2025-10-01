variable "name"                   { type = string }
variable "vpc_id"                 { type = string }
variable "private_subnet_ids"     { type = list(string) }
variable "public_subnet_ids"      { type = list(string) }
variable "ecr_repository_url"     { type = string }
variable "image_tag"              { type = string }
variable "container_port"         { type = number }
variable "desired_count"          { type = number }
variable "cpu"                    { type = number }
variable "memory"                 { type = number }
variable "ecs_task_execution_arn" { type = string }
variable "ecs_task_role_arn"      { type = string }
variable "tags" {
  type    = map(string)
  default = {}
}
