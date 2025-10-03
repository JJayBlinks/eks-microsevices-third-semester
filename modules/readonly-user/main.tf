resource "aws_iam_user" "readonly_user" {
  name = "${var.cluster_name}-readonly-user"
  path = "/eks/"

  tags = merge(var.common_tags, {
    Name = "${var.cluster_name}-readonly-user"
    Type = "eks-readonly-user"
  })
}

resource "aws_iam_access_key" "readonly_user" {
  user = aws_iam_user.readonly_user.name
}

resource "aws_iam_user_policy" "readonly_eks_policy" {
  name = "${var.cluster_name}-readonly-eks-policy"
  user = aws_iam_user.readonly_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:DescribeCluster",
          "eks:ListClusters"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "kubernetes_cluster_role" "readonly" {
  metadata {
    name = "eks-readonly"
  }

  rule {
    api_groups = [""]
    resources  = ["*"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["apps", "extensions"]
    resources  = ["*"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["batch"]
    resources  = ["*"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "readonly" {
  metadata {
    name = "eks-readonly-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.readonly.metadata[0].name
  }

  subject {
    kind      = "User"
    name      = "readonly-user"
    api_group = "rbac.authorization.k8s.io"
  }
}