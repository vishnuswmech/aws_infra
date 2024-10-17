resource "aws_eks_node_group" "eks-ng1" {
  cluster_name    = var.cluster_name
  node_group_name = var.ng1_name
  node_role_arn   = aws_iam_role.ng_role.arn
  subnet_ids      = var.subnet_ids
  version         = var.eks_version
  instance_types  = var.ng_instance_type
  disk_size       = var.ng_disk_size

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }
  remote_access {
    ec2_ssh_key = var.ssh_key_name


  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.ng-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.ng-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.ng-AmazonEC2ContainerRegistryReadOnly, aws_eks_cluster.vishnu-eks
  ]
}

resource "aws_iam_role" "ng_role" {
  name = "eks-node-group-ng"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "ng-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.ng_role.name
}

resource "aws_iam_role_policy_attachment" "ng-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.ng_role.name
}

resource "aws_iam_role_policy_attachment" "ng-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.ng_role.name
}