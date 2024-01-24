FROM --platform=linux/aarch64 ubuntu:latest as build
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

COPY ./morelloie.tgz.sh ./morello-llvm-linux-aarch64.tar.gz ./musl-sysroot-hybrid.tar.gz ./musl-sysroot-purecap.tar.gz /root/

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

FROM --platform=linux/aarch64 ubuntu:latest as main
COPY --from=build /root/morelloie /root/musl-sysroot-hybrid /root/musl-sysroot-purecap /root/llvm /root/

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
