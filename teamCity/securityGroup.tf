resource "aws_security_group" "teamcity_security_group" {
  name        = "teamcity_security_group"
  description = "control access to teamcity server"

  tags {
    Name  = "${var.Tag_Name}"
    Stage = "${var.Tag_Stage}"
    Owner = "${var.Tag_Owner}"
  }
}

#resource "aws_security_group_rule" "ingress_http" {
#  security_group_id = "${aws_security_group.teamcity_security_group.id}"
#  type              = "ingress"
#  from_port         = 80
#  to_port           = 80
#  protocol          = "tcp"
#  cidr_blocks       = ["0.0.0.0/0"]
#}

#resource "aws_security_group_rule" "ingress_https" {
#  security_group_id = "${aws_security_group.teamcity_security_group.id}"
#  type              = "ingress"
#  from_port         = 443
#  to_port           = 443
#  protocol          = "tcp"
#  cidr_blocks       = ["0.0.0.0/0"]
#}

#resource "aws_security_group_rule" "ingress_reply" {
#  security_group_id = "${aws_security_group.teamcity_security_group.id}"
#  type              = "ingress"
#  from_port         = 1024
#  to_port           = 65535
#  protocol          = "tcp"
#  cidr_blocks       = ["0.0.0.0/0"]
#}

resource "aws_security_group_rule" "egress_reply" {
  security_group_id = "${aws_security_group.teamcity_security_group.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_ssh" {
  security_group_id = "${aws_security_group.teamcity_security_group.id}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.local_IP}/32"]
  description       = "SSH access for server management"
}
