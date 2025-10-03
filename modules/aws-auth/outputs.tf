output "configmap_name" {
  description = "Name of the aws-auth ConfigMap"
  value       = kubernetes_config_map.aws_auth.metadata[0].name
}

output "configmap_namespace" {
  description = "Namespace of the aws-auth ConfigMap"
  value       = kubernetes_config_map.aws_auth.metadata[0].namespace
}