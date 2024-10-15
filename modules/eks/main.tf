resource "aws_eks_cluster" "vishnu-eks" {
  count    = var.eks_creation ? 1 : 0
  name     = "vishnu-eks"
  role_arn = aws_iam_role.eks-role[count.index].arn


  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = false

  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy-attachment-to-eks-role,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController-attachment-to-eks-role,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.vishnu-eks[*].endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.vishnu-eks[*].certificate_authority[0].data
}




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

resource "aws_iam_role" "eks-role" {
  count              = var.eks_creation ? 1 : 0
  name               = "eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy-attachment-to-eks-role" {
  count      = var.eks_creation ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-role[count.index].name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController-attachment-to-eks-role" {
  count      = var.eks_creation ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks-role[count.index].name
}