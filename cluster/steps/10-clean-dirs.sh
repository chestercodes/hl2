
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
KUBE_DIR=$(realpath "$SCRIPT_DIR/../kube")
echo "kube dir is $KUBE_DIR"

sudo chmod -R 777 "$KUBE_DIR"

sudo rm -rf "$KUBE_DIR/agents/database/maindb-production"
