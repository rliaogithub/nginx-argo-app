# ArgoCD Applications

This directory contains ArgoCD Application manifests for managing authentication services independently.

## Applications

### Standalone Services

- **`dex-application.yaml`** - Dex OIDC Identity Provider

  - Source: `k8s/dex/`
  - Namespace: `default`
  - Auto-sync enabled

- **`oauth2-proxy-application.yaml`** - OAuth2-Proxy Authentication Gateway

  - Source: `k8s/oauth2-proxy/`
  - Namespace: `default`
  - Auto-sync enabled

- **`support-console-bff-application.yaml`** - Support Console Backend for Frontend

  - Source: `k8s/support-console-bff/`
  - Namespace: `support-console`
  - Auto-sync enabled

- **`support-console-application.yaml`** - Support Console Frontend
  - Source: `k8s/support-console/`
  - Namespace: `support-console`
  - Auto-sync enabled

### App-of-Apps Pattern

- **`auth-services-suite.yaml`** - Manages all authentication service applications
  - Creates and manages both Dex and OAuth2-Proxy applications
  - Uses ArgoCD "App-of-Apps" pattern

## Deployment Options

### Option 1: Deploy Individual Services

```bash
kubectl apply -f argocd-apps/dex-application.yaml
kubectl apply -f argocd-apps/oauth2-proxy-application.yaml
kubectl apply -f argocd-apps/support-console-bff-application.yaml
kubectl apply -f argocd-apps/support-console-application.yaml
```

### Option 2: Deploy All Services via App-of-Apps

```bash
kubectl apply -f argocd-apps/auth-services-suite.yaml
```

## Architecture

```
┌─────────────────┐    ┌──────────────────────┐    ┌─────────────────────┐
│   nginx-app     │    │   dex-auth-service   │    │ oauth2-proxy-auth-  │
│                 │    │                      │    │ service             │
│ - nginx/        │    │ - dex/               │    │ - oauth2-proxy/     │
│ - istio/        │    │                      │    │                     │
│   gateway.yaml  │    │                      │    │                     │
└─────────────────┘    └──────────────────────┘    └─────────────────────┘
         │                        │                           │
         └────────────────────────┼───────────────────────────┘
                                  │
                        ┌─────────▼──────────┐
                        │ Istio Gateway      │
                        │ (Shared Resource)  │
                        └────────────────────┘
```

## Benefits

1. **Service Independence** - Each authentication service can be updated independently
2. **Separation of Concerns** - nginx-app focuses only on the application, auth services are separate
3. **Reusability** - Auth services can be shared across multiple applications
4. **Easier Maintenance** - Clear boundaries between different service responsibilities
