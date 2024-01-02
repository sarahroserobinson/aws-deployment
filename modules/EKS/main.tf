# resource "aws_iam_role" "role" {
#   assume_role_policy = data.aws_iam_policy_document.example_assume_role_policy.json
#   name               = "example"
# }

# resource "aws_eks_cluster" "example" {
#   name     = "example-cluster"
#   role_arn = aws_iam_role.example.arn

#   vpc_config {
#     endpoint_private_access = true
#     endpoint_public_access  = false
#     # ... other configuration ...
#   }

#   outpost_config {
#     control_plane_instance_type = "m5d.large"
#     outpost_arns                = [data.aws_outposts_outpost.example.arn]
#   }
# }

