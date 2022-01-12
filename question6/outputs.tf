output "iam_user_name" {
  description = "The user's name"
  value       = aws_iam_user.this.name
}

output "iam_user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = aws_iam_user.this.arn
}

output "iam_group_name" {
  description = "The group's name"
  value       = aws_iam_group.this.name
}

output "iam_group_arn" {
  description = "The ARN assigned by AWS for this group"
  value       = aws_iam_group.this.name
}

output "iam_policy_name" {
  description = "The ARN assigned by AWS for this policy"
  value       = aws_iam_policy.this.name
}

output "iam_policy_arn" {
  description = "The ARN assigned by AWS for this policy"
  value       = aws_iam_policy.this.arn
}

output "iam_role_name" {
  description = "The ARN assigned by AWS for this role"
  value       = aws_iam_role.this.name
}

output "iam_role_arn" {
  description = "The ARN assigned by AWS for this role"
  value       = aws_iam_role.this.arn
}

