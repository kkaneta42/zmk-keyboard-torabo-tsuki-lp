# Docker Build Environment for ZMK Firmware

This Docker setup allows you to build the ZMK firmware locally without installing the entire toolchain on your host machine.

## Prerequisites

- Docker
- Docker Compose

## Quick Start

1. Build the firmware with a single command:
```bash
./docker-build.sh
```

This will:
- Build the Docker image with all necessary dependencies
- Initialize the West workspace
- Build all firmware configurations defined in `build.yaml`
- Output firmware files to the `firmware/` directory

## Manual Build

If you want more control over the build process:

1. Build the Docker image:
```bash
docker-compose build
```

2. Run the build script:
```bash
docker-compose run --rm zmk-build ./build.sh
```

3. Or enter the container for interactive development:
```bash
docker-compose run --rm zmk-build /bin/bash
```

Inside the container, you can run West commands directly:
```bash
west build -p -b bmp_boost -- -DSHIELD="torabo_tsuki_lp_left" -DZMK_CONFIG="/workspace/config"
```

## Output Files

After a successful build, firmware files will be available in the `firmware/` directory:
- `torabo_tsuki_lp_left_central.uf2`
- `torabo_tsuki_lp_right_peripheral.uf2`
- `torabo_tsuki_lp_left_peripheral.uf2`
- `torabo_tsuki_lp_right_central.uf2`
- `settings_reset.uf2`

## Cleaning Build Cache

To clean the build cache and start fresh:
```bash
docker-compose down -v
rm -rf firmware/
```

## Troubleshooting

If you encounter build errors:
1. Clean the Docker volumes: `docker-compose down -v`
2. Rebuild the Docker image: `docker-compose build --no-cache`
3. Check that all required files are present in the project directory