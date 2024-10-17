resource "aws_eks_addon" "kube-proxy" {
  count        = var.eks_creation ? 1 : 0
  cluster_name = aws_eks_cluster.vishnu-eks[count.index].name
  addon_name   = "kube-proxy"
}

resource "aws_eks_addon" "CoreDNS" {
  count        = var.eks_creation ? 1 : 0
  cluster_name = aws_eks_cluster.vishnu-eks[count.index].name
  addon_name   = "CoreDNS"
}

resource "aws_eks_addon" "Amazon-VPC-CNI" {
  count        = var.eks_creation ? 1 : 0
  cluster_name = aws_eks_cluster.vishnu-eks[count.index].name
  addon_name   = "Amazon VPC CNI"
}


resource "aws_eks_addon" "Amazon-EBS-CSI-Driver" {
  count        = var.eks_creation ? 1 : 0
  cluster_name = aws_eks_cluster.vishnu-eks[count.index].name
  addon_name   = "Amazon EBS CSI Driver"
}





