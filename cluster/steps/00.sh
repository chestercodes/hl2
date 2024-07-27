echo "homelab create folders"

read -p "Enter laptop or homelab:" lapOrHl

echo "Read '$lapOrHl'"

if [ $lapOrHl != "homelab" ]; then
    echo "'$lapOrHl' not valid"
    exit 1
fi

export HOST_DIR="/slowmirror/homelab"

sudo mkdir -p     "$HOST_DIR"
sudo mkdir -p     "$HOST_DIR/agents"
sudo mkdir -p     "$HOST_DIR/agents/database"
sudo mkdir -p     "$HOST_DIR/agents/database/maindb-production"
sudo chmod -R 777 "$HOST_DIR"
