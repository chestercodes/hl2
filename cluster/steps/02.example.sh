echo "create secrets"

export GH_NAME="change_me"
export GH_EMAIL="change_me"
export GH_USERNAME="change_me"
# github PAT
export GH_PASSWORD="change_me"
# random string to use as webhook auth token
export GH_WEBHOOK_SECRET="change_me"

# cloudflare tunnel token for github events
export GITHUB_WEBHOOKS_TUNNEL_TOKEN="change_me"

# passwords for postgresql server users
export PG_PROD_POSTGRES="change_me"
export PG_PROD_MIGRATIONS="change_me"

# auth tokens for dashboards
export PGADMIN_PASSWORD="change_me"
export ASPIRE_TOKEN="change_me"

kubectl create namespace argocd
kubectl create namespace pipeline
kubectl create namespace staging
kubectl create namespace production
kubectl create namespace monitoring

kubectl create secret -n production docker-registry ghcr --docker-server=https://ghcr.io/ --docker-username=$GH_USERNAME --docker-password=$GH_PASSWORD --docker-email=$GH_EMAIL
kubectl create secret -n staging docker-registry ghcr --docker-server=https://ghcr.io/ --docker-username=$GH_USERNAME --docker-password=$GH_PASSWORD --docker-email=$GH_EMAIL

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: github-webhook-tunnel
  namespace: pipeline
stringData:
  tunnel-token: ${GITHUB_WEBHOOKS_TUNNEL_TOKEN}
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: github-creds
  namespace: argocd
type: Opaque
stringData:
  name: ${GH_NAME}
  email: ${GH_EMAIL}
  username: ${GH_USERNAME}
  password: ${GH_PASSWORD}
  token: ${GH_PASSWORD}
  webhookSecret: ${GH_WEBHOOK_SECRET}
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: github-creds
  namespace: pipeline
type: Opaque
stringData:
  name: ${GH_NAME}
  email: ${GH_EMAIL}
  username: ${GH_USERNAME}
  password: ${GH_PASSWORD}
  token: ${GH_PASSWORD}
  webhookSecret: ${GH_WEBHOOK_SECRET}
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: github-creds
  namespace: staging
type: Opaque
stringData:
  name: ${GH_NAME}
  email: ${GH_EMAIL}
  username: ${GH_USERNAME}
  password: ${GH_PASSWORD}
  token: ${GH_PASSWORD}
  webhookSecret: ${GH_WEBHOOK_SECRET}
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: github-creds
  namespace: production
type: Opaque
stringData:
  name: ${GH_NAME}
  email: ${GH_EMAIL}
  username: ${GH_USERNAME}
  password: ${GH_PASSWORD}
  token: ${GH_PASSWORD}
  webhookSecret: ${GH_WEBHOOK_SECRET}
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: maindb-postgresql
  namespace: production
stringData:
  postgres-password: ${PG_PROD_POSTGRES}
  migrations-password: ${PG_PROD_MIGRATIONS}
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: pgadmin
  namespace: production
stringData:
  password: ${PGADMIN_PASSWORD}
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: aspire-dashboard
  namespace: monitoring
stringData:
  token: ${ASPIRE_TOKEN}
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: aspire-dashboard
  namespace: staging
stringData:
  token: ${ASPIRE_TOKEN}
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: aspire-dashboard
  namespace: production
stringData:
  token: ${ASPIRE_TOKEN}
EOF