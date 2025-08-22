FROM zmkfirmware/zmk-build-arm:stable

# Install additional dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    wget \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    ninja-build \
    gperf \
    ccache \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Copy the entire project
COPY . .

# Initialize west workspace
RUN west init -l config && \
    west update && \
    west zephyr-export

# Set environment variables for the build
ENV ZEPHYR_TOOLCHAIN_VARIANT=zephyr

# Default command - will be overridden by docker-compose
CMD ["/bin/bash"]