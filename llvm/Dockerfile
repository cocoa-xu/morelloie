FROM --platform=linux/aarch64 ubuntu:latest
LABEL maintainer="Cocoa <i@uwucocoa.moe>"

WORKDIR /root
ENV MORELLOIE_PREFIX=/root/morelloie \
    LLVM_PREFIX=/root/llvm \
    MUSL_SOURCES=/root/musl \
    MUSL_PREFIX_HYBRID=/root/musl-sysroot-hybrid \
    MUSL_PREFIX_PURECAP=/root/musl-sysroot-purecap \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/llvm/bin:/root/morelloie/bin \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

COPY morelloie.tgz.sh /root/morelloie.tgz.sh
COPY morello-llvm-linux-aarch64.tar.gz /root/morello-llvm-linux-aarch64.tar.gz
COPY musl-sysroot-hybrid.tar.gz /root/musl-sysroot-hybrid.tar.gz
COPY musl-sysroot-purecap.tar.gz /root/musl-sysroot-purecap.tar.gz

RUN apt-get update -q=2 && \
    apt-get install -q=2 --yes \
        --no-install-recommends --no-install-suggests \
        curl git make sudo locales ca-certificates vim nano && \
    dpkg-reconfigure locales && \
    update-locale && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen

RUN cd /root && \
    chmod a+x "/root/morelloie.tgz.sh" && \
    /root/morelloie.tgz.sh --i-agree-to-the-contained-eula --prefix=${MORELLOIE_PREFIX} && \
    rm -rf "/root/morelloie.tgz.sh" && \
    mkdir -p ${LLVM_PREFIX} && \
    tar -xf "/root/morello-llvm-linux-aarch64.tar.gz" -C "${LLVM_PREFIX}" --strip-components=1 && \
    rm -rf "/root/morello-llvm-linux-aarch64.tar.gz" && \
    mkdir -p ${MUSL_PREFIX_HYBRID} && \
    tar -xf "/root/musl-sysroot-hybrid.tar.gz" -C "${MUSL_PREFIX_HYBRID}" --strip-components=1 && \
    rm -rf "/root/musl-sysroot-hybrid.tar.gz" && \
    mkdir -p ${MUSL_PREFIX_PURECAP} && \
    tar -xf "/root/musl-sysroot-purecap.tar.gz" -C "${MUSL_PREFIX_PURECAP}" --strip-components=1 && \
    rm -rf "/root/musl-sysroot-purecap.tar.gz" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "root:root" | chpasswd
