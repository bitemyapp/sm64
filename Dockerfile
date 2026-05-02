# Ubuntu 18.04's mips binutils package is only available for amd64.
# Pinning the base image keeps Docker builds working on Apple Silicon via emulation.
ARG BASE_PLATFORM=linux/amd64
FROM --platform=${BASE_PLATFORM} ubuntu:18.04 AS build

RUN apt-get update && \
    apt-get install -y \
        binutils-mips-linux-gnu \
        bsdmainutils \
        build-essential \
        git \
        pkgconf \
        python3

RUN mkdir /sm64
WORKDIR /sm64
ENV PATH="/sm64/tools:${PATH}"

CMD echo 'usage: docker run --rm --mount type=bind,source="$(pwd)",destination=/sm64 sm64 make VERSION=us -j4\n' \
         'see https://github.com/n64decomp/sm64/blob/master/README.md for advanced usage'
