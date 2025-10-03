# Helm Deployment Guide

## 📦 Helm Chart Structure

```
helm-chart/
├── Chart.yaml          # Chart metadata
├── values.yaml         # Default configuration values
└── templates/
    ├── _helpers.tpl     # Template helpers
    ├── deployment.yaml  # Application deployment
    ├── service.yaml     # Kubernetes service
    └── hpa.yaml        # Horizontal Pod Autoscaler
```

## 🚀 GitHub Actions Integration

The deployment workflow automatically:
- Retrieves database credentials from AWS Secrets Manager
- Installs Helm 3.12.0
- Deploys using `helm upgrade --install`
- Passes database configurations as Helm values
- Verifies deployment status

## 🔧 Configuration

### Database Integration
Database credentials are automatically injected from AWS Secrets Manager:
- **PostgreSQL**: Host, username, password, database
- **MySQL**: Host, username, password, database  
- **Redis**: Host, password, port

### Environment Variables
The deployment template creates these environment variables:
```yaml
POSTGRES_HOST, POSTGRES_USERNAME, POSTGRES_PASSWORD
MYSQL_HOST, MYSQL_USERNAME, MYSQL_PASSWORD
REDIS_HOST, REDIS_PASSWORD
```

## 📋 Manual Deployment

### Prerequisites
```bash
# Install Helm
curl https://get.helm.sh/helm-v3.12.0-linux-amd64.tar.gz | tar xz
sudo mv linux-amd64/helm /usr/local/bin/

# Configure kubectl
aws eks update-kubeconfig --region us-east-1 --name prod-eks-cluster
```

### Deploy Application
```bash
# Get database secrets
POSTGRES_SECRET=$(aws secretsmanager get-secret-value --secret-id prod-eks-cluster-postgresql-credentials --query SecretString --output text)
MYSQL_SECRET=$(aws secretsmanager get-secret-value --secret-id prod-eks-cluster-mysql-credentials --query SecretString --output text)
REDIS_SECRET=$(aws secretsmanager get-secret-value --secret-id prod-eks-cluster-redis-credentials --query SecretString --output text)

# Deploy with Helm
helm upgrade --install microservices ./helm-chart \
  --set database.postgresql.host=$(echo $POSTGRES_SECRET | jq -r '.host') \
  --set database.postgresql.username=$(echo $POSTGRES_SECRET | jq -r '.username') \
  --set database.postgresql.password=$(echo $POSTGRES_SECRET | jq -r '.password') \
  --set database.mysql.host=$(echo $MYSQL_SECRET | jq -r '.host') \
  --set database.mysql.username=$(echo $MYSQL_SECRET | jq -r '.username') \
  --set database.mysql.password=$(echo $MYSQL_SECRET | jq -r '.password') \
  --set database.redis.host=$(echo $REDIS_SECRET | jq -r '.host') \
  --set database.redis.password=$(echo $REDIS_SECRET | jq -r '.password')
```

### Verify Deployment
```bash
helm status microservices
kubectl get pods -l app.kubernetes.io/name=microservices
kubectl logs -l app.kubernetes.io/name=microservices
```

## 🔄 Customization

### Update values.yaml
```yaml
image:
  repository: your-ecr-repo
  tag: "v1.0.0"

resources:
  limits:
    cpu: 1000m
    memory: 1Gi
  requests:
    cpu: 500m
    memory: 512Mi

autoscaling:
  minReplicas: 3
  maxReplicas: 20
```

### Environment-Specific Values
Create environment-specific value files:
- `values-dev.yaml`
- `values-staging.yaml`
- `values-prod.yaml`

Deploy with specific values:
```bash
helm upgrade --install microservices ./helm-chart -f values-prod.yaml
```