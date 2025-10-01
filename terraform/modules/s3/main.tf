variable "name"        { type = string }
variable "create_logs" {
  type    = bool
  default = true
}
variable "tags" {
  type    = map(string)
  default = {}
}

resource "aws_s3_bucket" "artifacts" {
  bucket = "${var.name}-artifacts"
  force_destroy = true
  tags = var.tags
}

resource "aws_s3_bucket" "logs" {
  count  = var.create_logs ? 1 : 0
  bucket = "${var.name}-logs"
  force_destroy = true
  tags = var.tags
}

output "artifacts_bucket" { value = aws_s3_bucket.artifacts.bucket }
output "logs_bucket"      { value = try(aws_s3_bucket.logs[0].bucket, null) }
