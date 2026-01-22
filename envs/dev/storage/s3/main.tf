module "s3_bucket" {
  source  = "../../../../modules/storage/s3"
  buckets = var.buckets

}