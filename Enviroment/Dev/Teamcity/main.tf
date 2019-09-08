provider "aws" {
  profile = "terraform"
  region  = "ca-central-1"
}

module "teamcity" {
  source = "../../../modules/teamcity"

  key_name = "teamcity2"
}
