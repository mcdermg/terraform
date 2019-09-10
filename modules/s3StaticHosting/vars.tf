variable "profile" {
  default = "terraform"
  description = "AWS profile to use"
}

variable "region" {
  default = "ca-central-1"
}

variable "name_length" {
  default = 2
  description = "Terrafrom pet name lentch for addition to the bucket name for uniqueness"
}

variable "site_name" {
  description = "The name of the site"
}

variable "certificate_arn" {
  description = "AWS acm certificate ARN. Due to manual reuirment with verify not automating"
  
}
