FROM --platform=linux/aarch64 ubuntu:latest as build
LABEL maintainer="Cocoa <i@uwucocoa.moe>"

WORKDIR /root
ENV MORELLOIE_PREFIX=/root/morelloie \
    GCC_PREFIX=/root/aarch64-none-linux-gnu \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/aarch64-none-linux-gnu/bin:/root/morelloie/bin \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

COPY ./morelloie.tgz.sh ./arm-gnu-toolchain-aarch64-aarch64-none-linux-gnu.tar.xz /root/

RUN apt-get update -q=2 && \
    apt-get install -q=2 --yes \
        --no-install-recommends --no-install-suggests xz-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /root && \
    chmod a+x "/root/morelloie.tgz.sh" && \
    /root/morelloie.tgz.sh --i-agree-to-the-contained-eula --prefix=${MORELLOIE_PREFIX} && \
    rm -rf "/root/morelloie.tgz.sh" && \
    mkdir -p ${GCC_PREFIX} && \
    tar -xf "/root/arm-gnu-toolchain-aarch64-aarch64-none-linux-gnu.tar.xz" -C "${GCC_PREFIX}" --strip-components=1 && \
    rm -f "/root/arm-gnu-toolchain-aarch64-aarch64-none-linux-gnu.tar.xz"

FROM --platform=linux/aarch64 ubuntu:latest as main
COPY --from=build /root/morelloie /root/aarch64-none-linux-gnu /root/

WORKDIR /root

ENV MORELLOIE_PREFIX=/root/morelloie \
    GCC_PREFIX=/root/aarch64-none-linux-gnu \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/aarch64-none-linux-gnu/bin:/root/morelloie/bin \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

RUN echo "root:root" | chpasswd
