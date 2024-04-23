data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "master_role" {
  name               = "eks-masternode-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "masternode-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.master_role.name
}

resource "aws_eks_cluster" "eks-project" {
  name     = var.cluster_name
  role_arn = aws_iam_role.master_role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private_subnet_az1.id,
      aws_subnet.private_subnet_az2.id
    ]
    endpoint_private_access = true
  }

  depends_on = [aws_iam_role_policy_attachment.masternode-AmazonEKSClusterPolicy]
}
