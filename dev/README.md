# Dev setup (Hydra + Postgres)

## Prerequisites

- Docker Desktop
- docker compose

## Setup

1) Create the env file:

```bash
cp dev/.env.example dev/.env
```

2) Start Postgres + Hydra:

```bash
docker compose -f dev/docker-compose.yml --env-file dev/.env up --build
```

Hydra endpoints:

- Public: http://localhost:4444
- Admin: http://localhost:4445

## Notes

- `RUN_MIGRATIONS=true` is enabled in compose, so Hydra will run SQL migrations automatically on boot.
- OAuth2/OIDC flows require a login+consent app. Set `LOGIN_CONSENT_URL` to wherever your login/consent UI runs.
