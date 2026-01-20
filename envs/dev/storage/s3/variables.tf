variable "buckets" {
  type = map(object({
    bucket_name = string
    environment = string
  }))
}
