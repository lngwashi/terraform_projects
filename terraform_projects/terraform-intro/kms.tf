
resource "aws_kms_key" "auto" {
  deletion_window_in_days = 15

}
