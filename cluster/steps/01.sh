echo "create laptop cluster"

# needed in config file
export BASE_DIR=$(pwd)
export HOST_DIR="$BASE_DIR/kube"

echo "Creating cluster with data dir $HOST_DIR"

k3d cluster create --config "$BASE_DIR/k3d/config.yaml" --wait

echo "Wait 60s for cluster to be ready..."
sleep 60