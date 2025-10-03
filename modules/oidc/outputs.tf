output "oidc_provider_arn" {
  description = "ARN of the OIDC provider"
  value       = aws_iam_openid_connect_provider.eks.arn
}

output "oidc_provider_url" {
  description = "URL of the OIDC provider"
  value       = aws_iam_openid_connect_provider.eks.url
}

output "oidc_provider_thumbprint" {
  description = "Thumbprint of the OIDC provider"
  value       = data.tls_certificate.eks.certificates[0].sha1_fingerprint
}