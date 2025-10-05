# Support Console Integration

## Overview

The OAuth2-Proxy authentication gateway has been updated to protect the Support Console frontend instead of the nginx service.

## Access URLs

- **Application**: http://oauth2-proxy.local (OAuth2-Proxy authentication gateway)
- **After authentication**: Redirects to Support Console UI
- **Direct Istio access**: http://support-console.istio.local (bypasses OAuth2-Proxy)
- **Dex authentication**: http://dex.istio.local/dex
- **Test user**: ron@example.com / Password123!

## Architecture

```
User → oauth2-proxy.local → OAuth2-Proxy → Support Console UI → Support Console BFF
                              ↓ (auth)
                           dex.istio.local
```

## Services

1. **Support Console (Frontend)**: UI application on port 8080
2. **Support Console BFF**: Backend-for-Frontend API on port 8080
3. **OAuth2-Proxy**: Authentication gateway on port 4180
4. **Dex**: OIDC provider on port 5556
5. **Nginx**: Still available but no longer protected by OAuth2-Proxy

## Changes Made

- OAuth2-Proxy upstream changed from nginx to support-console
- Istio Gateway updated to route support-console.istio.local
- VirtualService updated to point to support-console service
- Added support-console to main kustomization.yaml

## Testing

1. Access http://oauth2-proxy.local
2. Should redirect to Dex for authentication
3. Login with ron@example.com / Password123!
4. Should be redirected back to Support Console UI
