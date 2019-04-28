provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
}

resource "aws_db_instance" "default" {
  allocated_storage    = "${var.allocated_storage}"
  storage_type         = "${var.storage_type}"
  engine               = "${var.engine}"
  engine_version       = "${var.engine_version}"
  instance_class       = "${var.instance_class}"
  name                 = "${var.database_name}"
  username             = "${var.username}"
  password             = "${var.password}"
  parameter_group_name = "default.mysql5.7"
  identifier           = "${var.identifier}"
  # No final snapshot when using Terraform destroy
  skip_final_snapshot  = "True"

  tags {
    Name  = "${var.Tag_Name}"
    Stage = "${var.Tag_Stage}"
    Owner = "${var.Tag_Owner}"
  }

  provisioner "local-exec" {
    command = "echo #!/usr/bin/env python
    import preprocessing

    mysql = {'host': '${aws_db_instance.default.address}',
             'user': '${aws_db_instance.default.username}',
             'password': '${aws_db_instance.default.password}',
             'db': '${aws_db_instance.default.name}'
             } > databaseconfig.py"
  }
}
