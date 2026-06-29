# Multi-process container: Ollama + OpenClaw gateway
FROM node:22-bookworm-slim

RUN apt-get update && apt-get install -y \
    curl ca-certificates bash gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama binary
RUN curl -fsSL https://ollama.com/install.sh | sh

# Install OpenClaw
RUN npm install -g openclaw@latest

RUN mkdir -p /root/.ollama /root/.openclaw/workspace

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 18789
ENTRYPOINT ["/entrypoint.sh"]
