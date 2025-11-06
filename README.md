# Tiny PHP - Minimal Docker Images with Static PHP

A proof-of-concept project demonstrating how to create extremely small Docker images using statically compiled PHP binaries. All images are built from `scratch`, resulting in minimal footprint containers.

## Overview

This project uses [static-php-cli](https://github.com/crazywhalecc/static-php-cli) to build standalone PHP binaries and packages them into minimal Docker images. Three different runtime configurations are included:

- **php-server**: Simple PHP built-in web server
- **webman**: Webman framework with micro.sfx runtime
- **workerman_sf**: Symfony application with Workerman runtime

## Features

- 🐳 Ultra-small - 1.8MB -Docker images built from `scratch`
- 📦 Statically compiled PHP 8.4 binaries
- 🚀 No external dependencies required
- ⚡ Fast startup and minimal resource usage

## Prerequisites

- Docker
- Bash shell
- curl

## Quick Start

### Pull Pre-built Images

The easiest way to try these images is to pull them directly from Docker Hub:

```bash
docker pull crazygoat/tinyphp:php-server
docker pull crazygoat/tinyphp:webman
docker pull crazygoat/tinyphp:symfony
```

Then run any of them:

```bash
docker run -p 8080:8080 crazygoat/tinyphp:php-server
```

### Build Locally

To build all runtimes and Docker images from source:

```bash
./build.sh
```

This script will:
1. Download the static-php-cli binary (`spc`)
2. Build PHP binaries for each runtime using their respective `craft.yml` configurations
3. Create Docker images for all three runtimes

## Runtime Configurations

### PHP Server (`crazygoat/tinyphp:php-server`)

Basic PHP CLI runtime with built-in web server.

```bash
docker run -p 8080:8080 crazygoat/tinyphp:php-server
```

**Configuration**: `runtimes/php-server/craft.yml`
- PHP 8.4
- Extensions: posix
- SAPI: cli

### Webman (`crazygoat/tinyphp:webman`)

[Webman](https://www.workerman.net/webman) framework packaged as a single executable using micro.sfx.

```bash
docker run -p 8080:8080 crazygoat/tinyphp:webman
```

### Workerman + Symfony (`crazygoat/tinyphp:symfony`)

Symfony application with [Workerman](https://www.workerman.net/) runtime bundle.

```bash
docker run -p 8080:8080 crazygoat/tinyphp:symfony
```

## Project Structure

```
.
├── build.sh              # Main build script
├── spc                   # Static PHP CLI binary (downloaded)
├── runtimes/
│   ├── php-server/       # PHP built-in server runtime
│   ├── webman/           # Webman framework runtime
│   └── workerman_sf/     # Symfony + Workerman runtime
├── buildroot/            # Build artifacts
├── downloads/            # Downloaded dependencies
└── pkgroot/              # Package root directory
```

## Docker Images

All images are tagged under `crazygoat/tinyphp`:

- `crazygoat/tinyphp:latest` → php-server
- `crazygoat/tinyphp:php-server` → PHP built-in server
- `crazygoat/tinyphp:webman` → Webman framework
- `crazygoat/tinyphp:symfony` → Symfony + Workerman

## How It Works

The project uses `static-php-cli` (spc) to compile PHP and its extensions into a single static binary. Each runtime has a `craft.yml` file that defines:

- PHP version
- Required extensions
- SAPI type (cli or micro)
- Build options

These binaries are then copied into `FROM scratch` Docker images, resulting in containers that contain only the essential files needed to run.

## Benefits of Static PHP Binaries

- **Minimal attack surface**: No unnecessary system libraries or utilities
- **Portable**: Single binary runs anywhere without dependencies
- **Fast**: No dynamic linking overhead
- **Consistent**: Same binary works across different environments

## License

This is a proof-of-concept project. Check individual runtime directories for their respective licenses.

## Resources

- [static-php-cli](https://github.com/crazywhalecc/static-php-cli)
- [Webman Framework](https://www.workerman.net/webman)
- [Workerman](https://www.workerman.net/)
