#!/bin/sh
set -eu

: "${DSN:?Missing DSN}"
: "${HYDRA_PUBLIC_URL:?Missing HYDRA_PUBLIC_URL}"
: "${HYDRA_ADMIN_URL:?Missing HYDRA_ADMIN_URL}"
: "${LOGIN_CONSENT_URL:?Missing LOGIN_CONSENT_URL}"
: "${SYSTEM_SECRET:?Missing SYSTEM_SECRET}"
: "${COOKIE_SECRET:?Missing COOKIE_SECRET}"

envsubst < /etc/hydra/hydra.yml.tmpl > /etc/hydra/hydra.yml

if [ "${RUN_MIGRATIONS:-false}" = "true" ]; then
  hydra -c /etc/hydra/hydra.yml migrate sql up -e --yes
fi

exec hydra -c /etc/hydra/hydra.yml serve all ${HYDRA_EXTRA_ARGS:-}
