FROM python:3.9.2-slim-buster

RUN groupadd -r appuser -g 1001 && useradd -u 1001 -r -g appuser -m -d /app -s /sbin/nologin -c "App user" appuser && chmod 755 /app && \
    apt-get update && apt-get install -y build-essential wget curl net-tools python-dev libpq-dev && \
    rm -rf /var/lib/apt/lists/*
