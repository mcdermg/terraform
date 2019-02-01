provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "aurora-cluster-demo-${count.index}"
  cluster_identifier = "${aws_rds_cluster.default.id}"
  instance_class     = "${var.}"
}

resource "aws_rds_cluster" "default" {
  cluster_identifier = "${var.}"
  availability_zones = ["eu-west-1", "eu-west-2", "eu-west-3",]
  database_name      = "${var.database_name}"
  master_username    = "${var.master_username}"
  master_password    = "${var.master_password}"
}
