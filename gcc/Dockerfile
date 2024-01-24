FROM --platform=linux/aarch64 ubuntu:latest
LABEL maintainer="Cocoa <i@uwucocoa.moe>"

WORKDIR /root
ENV MORELLOIE_PREFIX=/root/morelloie \
    GCC_PREFIX=/root/aarch64-none-linux-gnu \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/aarch64-none-linux-gnu/bin:/root/morelloie/bin \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

COPY morelloie.tgz.sh /root/morelloie.tgz.sh
COPY arm-gnu-toolchain-aarch64-aarch64-none-linux-gnu.tar.xz /root/arm-gnu-toolchain-aarch64-aarch64-none-linux-gnu.tar.xz

RUN apt-get update -q=2 && \
    apt-get install -q=2 --yes \
        --no-install-recommends --no-install-suggests \
        curl git make sudo locales ca-certificates xz-utils vim nano && \
    dpkg-reconfigure locales && \
    update-locale && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen

RUN cd /root && \
    cd /root && \
    chmod a+x "/root/morelloie.tgz.sh" && \
    /root/morelloie.tgz.sh --i-agree-to-the-contained-eula --prefix=${MORELLOIE_PREFIX} && \
    rm -rf "/root/morelloie.tgz.sh" && \
    tar -xf "/root/arm-gnu-toolchain-aarch64-aarch64-none-linux-gnu.tar.xz" -C "${GCC_PREFIX}" --strip-components=1 && \
    rm -f "/root/arm-gnu-toolchain-aarch64-aarch64-none-linux-gnu.tar.xz" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "root:root" | chpasswd
RUN update-alternatives --install \
    /usr/bin/gcc gcc /root/aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-gcc 10010 \
    --slave /usr/bin/g++ g++ /root/aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-g++
