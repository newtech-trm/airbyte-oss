# Use Ubuntu as base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV AIRBYTE_VERSION=0.63.15

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    git \
    docker.io \
    docker-compose \
    openjdk-17-jdk \
    python3 \
    python3-pip \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Create airbyte user
RUN useradd -m -s /bin/bash airbyte

# Create app directory
WORKDIR /app

# Copy source code
COPY . .

# Set proper permissions
RUN chown -R airbyte:airbyte /app

# Switch to airbyte user
USER airbyte

# Set environment variables for Railway
ENV AIRBYTE_ROLE=dev
ENV AIRBYTE_VERSION=${AIRBYTE_VERSION}
ENV DATABASE_URL=${DATABASE_URL}
ENV RAILWAY_STATIC_URL=${RAILWAY_STATIC_URL}
ENV PORT=8000

# Copy and set up startup script
COPY start-railway.sh /app/start.sh
RUN chmod +x /app/start.sh

# Expose port
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8000/ || exit 1

# Start command
CMD ["/app/start.sh"] 