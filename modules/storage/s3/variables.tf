variable "buckets" {
  type = map(object({
    bucket_name = string
    tags        = map(string)
  }))
}