variable "name" { type = string }
variable "tags" {
  type    = map(string)
  default = {}
}

resource "aws_ecr_repository" "this" {
  name                 = "${var.name}"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration { scan_on_push = true }
  tags = var.tags
}
