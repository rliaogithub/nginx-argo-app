# nginx-argo-app

A sample Nginx web application designed for testing Argo CD GitOps deployments on Kubernetes.

## Overview

This repository contains a simple Nginx web application that demonstrates:
- Containerized web application using Docker
- Kubernetes deployment manifests
- Argo CD application configuration for GitOps
- GitHub Actions for CI/CD pipeline

## Project Structure

```
.
├── html/
│   └── index.html          # Static web content
├── k8s/
│   ├── deployment.yaml     # Kubernetes deployment
│   ├── service.yaml        # Kubernetes service
│   ├── ingress.yaml        # Kubernetes ingress
│   └── kustomization.yaml  # Kustomize configuration
├── .github/workflows/
│   └── docker-build.yaml   # GitHub Actions workflow
├── Dockerfile              # Container image definition
├── argocd-app.yaml         # Argo CD application manifest
└── README.md
```

## Quick Start

### Prerequisites

- Docker
- Kubernetes cluster
- Argo CD installed on your cluster

### 1. Build and Run Locally

```bash
# Build the Docker image
docker build -t nginx-argo-app .

# Run locally
docker run -p 8080:80 nginx-argo-app
```

Visit `http://localhost:8080` to see the application.

### 2. Deploy to Kubernetes

```bash
# Apply Kubernetes manifests
kubectl apply -k k8s/

# Check deployment status
kubectl get pods -l app=nginx-argo-app
kubectl get svc nginx-argo-app-service
```

### 3. Deploy with Argo CD

```bash
# Apply the Argo CD application
kubectl apply -f argocd-app.yaml

# Check Argo CD application status
kubectl get applications -n argocd
```

## Configuration

### Argo CD Application

The application is configured to:
- Monitor the `main` branch of this repository
- Deploy to the `default` namespace
- Automatically sync changes (prune and self-heal enabled)
- Use the `k8s/` directory for Kubernetes manifests

### Kubernetes Resources

- **Deployment**: 2 replicas with resource limits
- **Service**: ClusterIP service exposing port 80
- **Ingress**: Optional ingress for external access (host: `nginx-argo-app.local`)

## Testing Argo CD

1. **Initial Deployment**: Apply the `argocd-app.yaml` to create the Argo CD application
2. **GitOps Testing**: Make changes to the Kubernetes manifests and push to the repository
3. **Auto-Sync**: Argo CD will automatically detect and apply changes
4. **Manual Sync**: Use Argo CD UI or CLI to manually trigger synchronization

## GitHub Actions

The repository includes a GitHub Actions workflow that:
- Builds the Docker image on every push/PR
- Pushes images to GitHub Container Registry (ghcr.io)
- Uses semantic versioning based on git references

## Customization

- **HTML Content**: Modify files in the `html/` directory
- **Kubernetes Config**: Update manifests in the `k8s/` directory
- **Argo CD Settings**: Modify `argocd-app.yaml` for different sync policies
- **Container Image**: Update the `Dockerfile` for custom nginx configuration

## Troubleshooting

### Common Issues

1. **Image Pull Errors**: Ensure the container image is accessible from your cluster
2. **Sync Issues**: Check Argo CD logs and application status
3. **Network Issues**: Verify service and ingress configurations

### Useful Commands

```bash
# Check pod logs
kubectl logs -l app=nginx-argo-app

# Port forward for local access
kubectl port-forward svc/nginx-argo-app-service 8080:80

# Check Argo CD application details
kubectl describe application nginx-argo-app -n argocd
```
