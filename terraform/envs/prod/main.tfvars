env               = "prod"
region            = "us-east-1"
container_image_tag = "stable"
desired_count     = 3
cpu               = 512
memory            = 1024
tags = { Owner = "platform", CostCenter = "prod" }
