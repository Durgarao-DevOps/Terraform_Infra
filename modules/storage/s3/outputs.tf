output "bucket_id" {
  value ={
    for k,bucket in aws_s3_bucket.this :
    k => bucket.id
  }
}