resource "aws_s3_bucket" "this" {
  for_each = var.buckets
  bucket   = each.value.bucket_name
  tags     = each.value.tags
}