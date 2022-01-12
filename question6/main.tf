# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_role" "this" {
  name                 = "${var.name}-role"
}


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "this" {
  name                 = "${var.name}-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "sts:AssumeRole"
        Resource = aws_iam_role.this.arn
      },
    ]
  })
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group
resource "aws_iam_group" "this" {
  name                 =  "${var.name}-group"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user
resource "aws_iam_user" "this" {
  name                 =  "${var.name}-user"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment
resource "aws_iam_group_policy_attachment" "this" {
  group      = aws_iam_group.this.name
  policy_arn = aws_iam_policy.this.arn
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership
resource "aws_iam_user_group_membership" "this" {
  user = aws_iam_user.this.name
  groups = [
    aws_iam_group.this.name,
  ]
}