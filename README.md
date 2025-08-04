# Docker Demo with Spring Boot 🚀

A comprehensive DevOps demonstration project showcasing the complete deployment pipeline of a Spring Boot application using Docker, Kubernetes, AWS EKS, Terraform, and GitHub Actions CI/CD.

## 📋 Project Overview

This project demonstrates modern DevOps practices by containerizing a simple Spring Boot application and deploying it to AWS EKS cluster using Infrastructure as Code (IaC) and automated CI/CD pipelines.

### 🎯 Key Components
- **Spring Boot Application** - Simple REST API
- **Docker** - Application containerization
- **Kubernetes** - Container orchestration with EKS
- **Terraform** - Infrastructure provisioning as code
- **GitHub Actions** - CI/CD pipeline automation
- **AWS EKS** - Managed Kubernetes service

## 🏗️ Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   GitHub Repo   │───▶│  GitHub Actions  │───▶│   Docker Hub    │
│                 │    │     CI/CD        │    │                 │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                                │                        │
                                ▼                        │
                       ┌──────────────────┐             │
                       │    Terraform     │             │
                       │ Infrastructure   │             │
                       │   Provisioning   │             │
                       └──────────────────┘             │
                                │                        │
                                ▼                        │
                       ┌──────────────────┐             │
                       │    AWS EKS       │◀────────────┘
                       │   Kubernetes     │
                       │    Cluster       │
                       └──────────────────┘
```

## 🚀 Features

### CI/CD Pipeline
- ✅ **Automated Build** - Maven build on code push
- ✅ **Docker Image** - Multi-platform container build and push
- ✅ **Infrastructure** - Terraform-managed AWS EKS cluster
- ✅ **Deployment** - Kubernetes deployment with rolling updates
- ✅ **Load Balancer** - AWS ELB for external access

### Infrastructure Components
- **VPC** with public/private subnets
- **EKS Cluster** with managed node groups
- **NAT Gateway** for private subnet internet access
- **Load Balancer** service for application access

## 📁 Project Structure

```
Docker_Demo/
├── src/                           # Spring Boot application source
├── Dockerfile                     # Container configuration
├── k8s-deployment.yaml           # Kubernetes manifests
├── .github/workflows/
│   └── deploy.yaml               # CI/CD pipeline
├── terraform/
│   ├── main.tf                   # Infrastructure definition
│   ├── variables.tf              # Terraform variables
│   ├── outputs.tf                # Output values
│   └── provider.tf               # Provider configuration
├── pom.xml                       # Maven dependencies
└── README.md
```

## 🛠️ Prerequisites

- AWS Account with appropriate permissions
- Docker Hub account
- GitHub repository with secrets configured
- Local development tools (optional):
  - Java 21
  - Maven
  - Docker
  - Terraform
  - kubectl

## ⚙️ GitHub Secrets Configuration

Configure the following secrets in your GitHub repository:

```bash
# Docker Hub
DOCKER_USERNAME=your-dockerhub-username
DOCKER_PASSWORD=your-dockerhub-password

# AWS Credentials
AWS_ACCESS_KEY_ID=your-aws-access-key
AWS_SECRET_ACCESS_KEY=your-aws-secret-key
AWS_REGION=ap-south-1

# EKS Configuration
EKS_CLUSTER_NAME=my-cluster
```

## 🚀 Deployment Process

### Automatic Deployment (Recommended)
Simply push to the `master` branch to trigger the complete CI/CD pipeline:

1. **Code Push** → Triggers GitHub Actions
2. **Build** → Maven compiles Spring Boot application
3. **Containerize** → Docker builds and pushes image to Docker Hub
4. **Infrastructure** → Terraform provisions AWS EKS cluster
5. **Deploy** → Kubernetes deploys application to EKS
6. **Access** → Application available via Load Balancer

### Manual Deployment

#### 1. Build Spring Boot Application
```bash
mvn clean package -DskipTests
```

#### 2. Build and Push Docker Image
```bash
docker build -t your-username/docker-demo:latest .
docker push your-username/docker-demo:latest
```

#### 3. Provision Infrastructure with Terraform
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

#### 4. Configure kubectl for EKS
```bash
aws eks update-kubeconfig --name my-cluster --region ap-south-1
```

#### 5. Deploy to Kubernetes
```bash
kubectl apply -f k8s-deployment.yaml
```

## 📋 Configuration Details

### Dockerfile
- **Base Image:** OpenJDK 21 Slim
- **Port:** 8080
- **JAR Location:** `/app/Docker_Demo_With_Springboot.jar`

### Kubernetes Deployment
- **Replicas:** 1 (configurable)
- **Service Type:** LoadBalancer
- **Port Mapping:** 80:8080
- **Image:** `tharanidharan/docker-demo:latest`

### Terraform Infrastructure
- **Region:** ap-south-1 (Mumbai)
- **VPC CIDR:** 10.0.0.0/16
- **Availability Zones:** ap-south-1a, ap-south-1b
- **Node Instance Type:** t2.micro
- **Node Group Size:** 1-3 nodes (desired: 2)

### GitHub Actions Pipeline
- **Trigger:** Push to master branch
- **Platform:** linux/amd64
- **Java Version:** 21 (Temurin distribution)
- **Terraform Version:** Latest

## 🌐 Accessing the Application

After successful deployment:

1. **Get Load Balancer URL:**
   ```bash
   kubectl get services docker-k8s-demo-service
   ```

2. **Access Application:**
   ```bash
   curl http://<EXTERNAL-IP>
   ```

The application will be accessible via the AWS Load Balancer's external IP/DNS.

## 📊 Monitoring and Management

### Check Deployment Status
```bash
kubectl get deployments
kubectl get pods
kubectl get services
```

### View Application Logs
```bash
kubectl logs -l app=docker-k8s-demo
```

### Scale Deployment
```bash
kubectl scale deployment docker-k8s-demo-deployment --replicas=3
```

### Rolling Update
```bash
kubectl rollout restart deployment docker-k8s-demo-deployment
```

## 🔧 Customization

### Change Application Configuration
- Modify Spring Boot application in `src/` directory
- Update Dockerfile if needed
- Push changes to trigger automatic deployment

### Modify Infrastructure
- Edit `terraform/variables.tf` for configuration changes
- Update `terraform/main.tf` for infrastructure modifications
- Changes will be applied on next pipeline run

### Update Kubernetes Configuration
- Modify `k8s-deployment.yaml` for deployment changes
- Adjust replicas, resources, or service configuration
- Apply changes via pipeline or manually with `kubectl apply`

## 🧹 Cleanup

### Destroy Infrastructure
```bash
cd terraform
terraform destroy
```

### Remove Docker Image
```bash
docker rmi your-username/docker-demo:latest
```

## 🚨 Troubleshooting

### Common Issues

1. **Pipeline Failures**
   - Check GitHub Actions logs
   - Verify all secrets are correctly configured
   - Ensure AWS permissions are sufficient

2. **Terraform Errors**
   - Validate Terraform syntax: `terraform validate`
   - Check AWS resource limits and quotas
   - Verify region and availability zone availability

3. **Kubernetes Deployment Issues**
   - Check pod status: `kubectl describe pod <pod-name>`
   - Verify image availability on Docker Hub
   - Check EKS cluster connectivity

4. **Application Access Issues**
   - Verify Load Balancer creation: `kubectl get svc`
   - Check security group configurations
   - Ensure EKS cluster has internet access

## 📚 Learning Outcomes

This project demonstrates:
- **Containerization** with Docker
- **Infrastructure as Code** with Terraform
- **Container Orchestration** with Kubernetes
- **CI/CD Automation** with GitHub Actions
- **Cloud Services** with AWS EKS
- **DevOps Best Practices** and workflows

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -m 'Add some improvement'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Open a Pull Request

## 👨‍💻 Author

**Tharani Dharan**
- GitHub: [@TharaniDharan10](https://github.com/TharaniDharan10)
- LinkedIn: [Tharani Dharan](https://www.linkedin.com/in/tharanidharan-s/)

## 🙏 Acknowledgments

- Spring Boot team for the excellent framework
- AWS for EKS and cloud infrastructure
- Terraform for infrastructure as code capabilities
- Docker for containerization technology
- Kubernetes community for orchestration platform
