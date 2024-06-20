output "iam_user_name" {
  value = aws_iam_user.user.name
}

output "access_key_id" {
  value = aws_iam_access_key.user_access_key.id
}

output "secret_access_key" {
  value = aws_iam_access_key.user_access_key.secret
}
