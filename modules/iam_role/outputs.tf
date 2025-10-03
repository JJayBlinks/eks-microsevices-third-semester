output "eks_cluster_role_arn" {
  description = "ARN of the EKS cluster IAM role"
  value       = aws_iam_role.eks_master_role.arn
}

output "eks_cluster_role_name" {
  description = "Name of the EKS cluster IAM role"
  value       = aws_iam_role.eks_master_role.name
}

output "eks_node_role_arn" {
  description = "ARN of the EKS node group IAM role"
  value       = aws_iam_role.eks_worker_role.arn
}

output "eks_node_role_name" {
  description = "Name of the EKS node group IAM role"
  value       = aws_iam_role.eks_worker_role.name
}

output "eks_ebs_csi_role_arn" {
  description = "ARN of the EKS EBS CSI driver IAM role"
  value       = var.enable_ebs_csi_driver ? aws_iam_role.eks_ebs_csi_driver_role[0].arn : null
}

output "eks_ebs_csi_role_name" {
  description = "Name of the EKS EBS CSI driver IAM role"
  value       = var.enable_ebs_csi_driver ? aws_iam_role.eks_ebs_csi_driver_role[0].name : null
}

output "all_role_arns" {
  description = "Map of all IAM role ARNs"
  value = {
    cluster_role = aws_iam_role.eks_master_role.arn
    node_role    = aws_iam_role.eks_worker_role.arn
    ebs_csi_role = var.enable_ebs_csi_driver ? aws_iam_role.eks_ebs_csi_driver_role[0].arn : null
  }
}

output "role_policy_attachments" {
  description = "Map of IAM role policy attachments"
  value = {
    cluster_policies = [aws_iam_role_policy_attachment.eks_cluster_policy_attach.policy_arn]
    node_policies = [
      aws_iam_role_policy_attachment.eks_worker_policy_attach.policy_arn,
      aws_iam_role_policy_attachment.eks_container_registry_ro_policy_attach.policy_arn,
      aws_iam_role_policy_attachment.eks_cni_policy_attach.policy_arn
    ]
    ebs_csi_policies = var.enable_ebs_csi_driver ? [aws_iam_role_policy_attachment.eks_ebs_csi_driver_policy_attach[0].policy_arn] : []
  }
}