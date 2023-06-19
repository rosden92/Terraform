#Create User  and attachment policy
#Create User test-user
resource "aws_iam_user" "test_user" {
  name = "test-user"
}

#Attachment policy from user
resource "aws_iam_user_policy_attachment" "test_user_policy_attachment" {
  user       = aws_iam_user.test_user.name
  policy_arn = aws_iam_policy.test_policy.arn
}
