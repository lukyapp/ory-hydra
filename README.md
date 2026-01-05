# Ory Hydra OAuth2 and OpenID Connect Server

[![Docker Pulls](https://img.shields.io/docker/pulls/oryd/hydra)](https://hub.docker.com/r/oryd/hydra/)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

A production-ready, cloud-native OAuth 2.0 and OpenID Connect server that provides secure authentication and authorization for your applications.

## 🔍 Overview

This repository provides a ready-to-use deployment setup for **Ory Hydra**, a production-grade **OAuth 2.0 and OpenID Connect server**.

Instead of re-implementing authentication standards, this project focuses on delivering a secure and cloud-native environment to run Hydra quickly in development or production, with Docker and PostgreSQL integration.

Ory Hydra is maintained by the Ory team and is widely used as an Identity and Authorization Provider in modern architectures.

👉 Official documentation: https://www.ory.sh/hydra/docs/

## 🚀 Key Features

This setup allows you to easily run and manage **Ory Hydra**, benefiting from all its built-in capabilities, including:

- **OAuth 2.0 & OpenID Connect compliance**  
  Full standards-based authentication and authorization support

- **JWT Access Tokens**  
  Secure token issuance using Hydra’s JWT strategies

- **PKCE Support**  
  Recommended security for public clients such as SPAs and mobile apps

- **Refresh Tokens & Session Management**  
  Support for long-lived sessions with secure rotation

- **Docker & Kubernetes Friendly Deployment**  
  Container-based setup designed for cloud-native environments

- **PostgreSQL Backend Integration**  
  Reliable persistence for clients, tokens, and consent sessions

For the complete list of features, refer to Hydra’s official docs:  
👉 https://www.ory.sh/hydra/docs/

## 🛠️ Tech Stack

- **Ory Hydra** - v25.4.0
- **PostgreSQL** - v16 (for token and configuration storage)
- **Docker** - Containerization
- **Docker Compose** - Local development and testing

## 🚀 Quick Start

### Prerequisites

- Docker and Docker Compose

### Local Development

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/ory-hydra.git
   cd ory-hydra
   ```

2. **Start the services**:
   ```bash
   docker-compose -f dev/docker-compose.yml up -d
   ```

3. **Verify the installation**:
   ```bash
   curl http://localhost:4445/health/ready
   ```

## 🔧 Configuration

The service is configured via environment variables. Key configurations include:

| Variable | Description | Example |
|----------|-------------|---------|
| `DSN` | Database connection string | `postgres://user:password@host:port/db` |
| `HYDRA_PUBLIC_URL` | Public URL of the service | `http://localhost:4444` |
| `HYDRA_ADMIN_URL` | Admin API URL | `http://localhost:4445` |
| `LOGIN_CONSENT_URL` | URL of the login/consent app | `http://localhost:3000` |
| `SYSTEM_SECRET` | Secret for encrypting sensitive data | `your-secure-secret` |
| `COOKIE_SECRET` | Secret for encrypting cookies | `your-cookie-secret` |

## 📂 Project Structure

```
ory-hydra/
├── Dockerfile          # Multi-stage Dockerfile for building the Hydra image
├── dev/               # Development configuration
│   └── docker-compose.yml  # Local development environment
├── entrypoint.sh      # Container entrypoint script
└── hydra.yml.tmpl     # Hydra configuration template
```

## 🔄 Creating OAuth2 Clients

### Public Client (SPA) Example

```bash
hydra create client \
    --endpoint http://localhost:4445 \
    --name "My SPA" \
    --grant-type authorization_code,refresh_token \
    --response-type code \
    --scope openid,profile,email,offline \
    --redirect-uri http://localhost:3000/callback \
    --token-endpoint-auth-method none \
    --access-token-strategy jwt
```

### Confidential Client (Server-side) Example

```bash
hydra create client \
    --endpoint http://localhost:4445 \
    --name "My Server App" \
    --grant-type authorization_code,refresh_token \
    --response-type code \
    --scope openid,profile,email,offline_access \
    --redirect-uri http://localhost:3000/api/auth/callback \
    --token-endpoint-auth-method client_secret_basic \
    --access-token-strategy jwt
```
