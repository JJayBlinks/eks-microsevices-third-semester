# GitHub Actions Setup for EKS Deployment

## 🔧 Setup Steps

### 1. Deploy Infrastructure
```bash
cd environments/prod
terraform apply
```

### 2. Get GitHub Actions Role ARN
```bash
terraform output github_actions_role_arn
```

### 3. Configure GitHub Repository

**Add Repository Secret:**
- Go to your GitHub repository
- Settings → Secrets and variables → Actions
- Add new repository secret:
  - Name: `AWS_ROLE_ARN`
  - Value: `arn:aws:iam::ACCOUNT:role/prod-eks-cluster-github-actions-role`

### 4. Update terraform.tfvars
```hcl
github_org  = "your-github-username-or-org"
github_repo = "your-repository-name"
```

### 5. Re-apply Terraform
```bash
terraform apply
```

## 🔐 Security Features

**OIDC Integration:**
- No long-term AWS credentials in GitHub
- Temporary credentials via OIDC token exchange
- Repository-specific access control

**IAM Permissions:**
- EKS cluster describe/list access
- ECR image pull permissions
- Secrets Manager read access for database credentials
- Scoped to specific cluster resources

**GitHub Actions Workflow:**
- Automatic AWS credential configuration
- EKS kubeconfig setup
- Database secrets retrieval
- Kubernetes deployment

## 🚀 Usage

**Automatic Deployment:**
- Push to `main` branch triggers deployment
- Pull requests run validation checks
- Secrets automatically retrieved from AWS Secrets Manager

**Manual Deployment:**
```bash
# Get cluster access
aws eks update-kubeconfig --region us-east-1 --name prod-eks-cluster

# Deploy your application
kubectl apply -f k8s/
```

## 📋 Required Repository Structure
```
your-repo/
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── configmap.yaml
└── .github/
    └── workflows/
        └── deploy.yml
```