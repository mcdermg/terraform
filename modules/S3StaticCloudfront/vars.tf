variable "site_name" {
  description = "The name of the site. Also used for the bucket name."
}

variable "certificate_arn" {
  description = "AWS acm certificate ARN. Due to manual reuirment with verify not automating"
  default = "arn:aws:acm:us-east-1:949207431024:certificate/f88d984e-b3c9-4ae9-a3f6-9deb4a369d48" 
}

variable "region" {
  default = "ca-central-1"
}