# Stage 1: take hydra binary from official image
FROM oryd/hydra:v25.4.0 AS hydra

# Stage 2: alpine runtime with envsubst
FROM alpine:3.20

RUN apk add --no-cache ca-certificates gettext

COPY --from=hydra /usr/bin/hydra /usr/bin/hydra

COPY hydra.yml.tmpl /etc/hydra/hydra.yml.tmpl
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 4444 4445
ENTRYPOINT ["/entrypoint.sh"]
