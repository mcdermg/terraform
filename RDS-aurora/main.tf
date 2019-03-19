provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "aurora-cluster-demo-${count.index}"
  cluster_identifier = "${aws_rds_cluster.default.id}"
  instance_class     = "${var.instance_class}"

  tags {
    Name  = "${var.Name}"
    Stage = "${var.Stage}"
    Owner = "${var.Owner}"
  }
}

resource "aws_rds_cluster" "default" {
  cluster_identifier = "${var.cluster_identifier}"
  availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c",]
  database_name      = "${var.database_name}"
  master_username    = "${var.master_username}"
  master_password    = "${var.master_password}"

  tags {
    Name  = "${var.Name}"
    Stage = "${var.Stage}"
    Owner = "${var.Owner}"
  }
}
