variable "user_name" {}

resource "aws_iam_user" "user" {
  name = "${var.user_name}"
}

resource "aws_iam_access_key" "key" {
  user = "${aws_iam_user.user.name}"
}

variable "policy_name" {}

variable "json_file_path" {}

resource "aws_iam_user_policy" "policy" {
  name = "${var.policy_name}"
  user = "${aws_iam_user.user.name}"

  policy = "${file("${var.json_file_path}")}"
}

output "secret" {
  value = "${aws_iam_access_key.key.secret}"
}
