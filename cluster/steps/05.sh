echo "print info"

PW_ARGO=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo "https://argocd.local - admin - $PW_ARGO"

echo ""
echo "or for homelab"
echo ""

echo "https://argocd.home.arpa - admin - $PW_ARGO"
