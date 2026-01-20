module "s3_bucket" {
  source = "../../../../modules/storage/s3"   
  for_each = var.buckets
  bucket_name = each.value.bucket_name
  environment = each.value.environment
  
}