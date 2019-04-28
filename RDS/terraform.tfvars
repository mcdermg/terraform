profile               = "labcli"
region                = "eu-west-1"

allocated_storage     = 10
storage_type          = "gp2"
engine                = "mysql"
engine_version        = "5.7"
instance_class        = "db.t2.micro"
database_name         = "awsdb"
username              = "admin"
password              = "Password1234"
#parameter_group_name = "default.mysql5.7"
identifier            = "db-123456789"

Tag_Name              = "Terraform"
Tag_Stage             = "Dev"
Tag_Owner             = "Gary Mc Dermott"
