FROM pytorch/pytorch:2.2.1-cuda12.1-cudnn8-runtime

WORKDIR /app

# Install system tools and Node.js (for n8n)
RUN apt-get update && apt-get install -y \
    libsndfile1 \
    ffmpeg \
    curl \
    git \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install n8n globally using npm
RUN npm install -g n8n@latest

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh


CMD ["/bin/bash"]
