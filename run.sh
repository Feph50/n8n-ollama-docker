#!/bin/bash
set -e

IMAGE_NAME="automation_notification"
CONTAINER_NAME="ollama_qwen2.5_3b"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# 1. Build Image
echo ">>> Building image..."
docker build -t "${IMAGE_NAME}" "${SCRIPT_DIR}"

# 2. Automatically select the least used GPU
SELECTED_GPU=$(nvidia-smi --query-gpu=index,memory.used --format=csv,noheader,nounits | sort -t',' -k2 -n | head -1 | cut -d',' -f1)
echo ">>> Using GPU: ${SELECTED_GPU}"

# 3. Start a fresh container
echo ">>> Starting container..."
docker run -it \
    --name "${CONTAINER_NAME}" \
    --gpus device=${SELECTED_GPU} \
    --network=host \
    --shm-size=4g \
    -v "${SCRIPT_DIR}:/app" \
    "${IMAGE_NAME}" \
    /bin/bash
