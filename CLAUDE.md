# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository contains a Docker-based setup for running a Snell proxy server (v5.0.0). Snell is a proxy protocol developed by Surge Network for fast and secure proxy connections.

## Architecture

The setup uses a multi-stage Docker build:
1. **Builder stage**: Alpine 3.21 - Downloads and prepares the Snell server binary from dl.nssurge.com
2. **Runtime stage**: Alpine Linux 3.9 with glibc 2.29-r0 (required for Snell binary compatibility)
3. **Entrypoint script**: Generates configuration from environment variables and launches the server

The container runs in host network mode to enable NAT Type A for UDP relay support.

**Important**: Alpine 3.9 + glibc 2.29-r0 is the stable combination. Newer Alpine versions (3.21) with glibc 2.35+ have dynamic linker compatibility issues with Snell binary.

## Configuration

Before running, edit `docker-compose.yml` to set:
- `SERVER_PORT`: The port Snell will listen on (replace `<port>`)
- `PSK`: Pre-shared key for authentication (replace `<password>`)
- `OBFS`: Obfuscation method (default: `http`)

If `PSK` is not provided, a random key will be generated at container startup.

## Common Commands

Build and run the server:
```bash
make run
```

This command:
- Builds the Docker image
- Recreates containers with new config
- Prunes unused images
- Follows logs (last 100 lines)

Stop the server:
```bash
make stop
```

Restart the server:
```bash
make restart
```

View logs manually:
```bash
docker-compose logs -f --tail=100
```

Check container health:
```bash
docker-compose ps
```

## Snell Version Updates

To update Snell server version, modify `SNELL_VERSION` in `Dockerfile:3`.

## Recent Optimizations (2025-10)

- Pinned Alpine builder version from `edge` to `3.21` for reproducible builds
- Removed unused `upx` package from builder stage
- Fixed shell script bug in docker-entrypoint.sh (line 22)
- Added health checks to monitor snell-server process
- Removed deprecated `version` field from docker-compose.yml
