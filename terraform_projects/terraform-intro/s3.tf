
resource "random_pet" "team_name" {
  prefix = "bootcamp30"
  length = 3
}

resource "aws_s3_bucket" "backend" {
  count = var.create_vpc ? 1 : 0
  //bucket = "lower(bootcamp30-${random_integer.s3.result}-${var.name}" 
  bucket = random_pet.team_name.id

  depends_on = [random_pet.team_name]
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backend" {
  bucket = aws_s3_bucket.backend[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.auto.arn
    }
  }
}

moved {
  from = random_pet.pet_name
  to   = random_pet.team_name
}
