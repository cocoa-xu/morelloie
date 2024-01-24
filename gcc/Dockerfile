FROM --platform=linux/aarch64 ubuntu:latest
LABEL maintainer="Cocoa <i@uwucocoa.moe>"

WORKDIR /root
ENV MORELLOIE_PREFIX=/root/morelloie \
    GCC_PREFIX=/root/aarch64-none-linux-gnu \
    GCC_VERSION="10.1.morello-alp2" \
    GCC_FULL_VERSION="arm-gnu-toolchain-10.1.morello-alp2-aarch64-aarch64-none-linux-gnu" \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/aarch64-none-linux-gnu/bin:/root/morelloie/bin \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

COPY morelloie.tgz.sh /root/morelloie.tgz.sh

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
    curl -fSL "https://developer.arm.com/-/media/Files/downloads/gnu-morello/${GCC_VERSION}/binrel/${GCC_FULL_VERSION}.tar.xz" \
        -o "${GCC_FULL_VERSION}.tar.xz" && \
    tar xf "${GCC_FULL_VERSION}.tar.xz" && \
    mv "./${GCC_FULL_VERSION}" "${GCC_PREFIX}" && \
    rm -f "${GCC_FULL_VERSION}.tar.xz" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "root:root" | chpasswd
RUN update-alternatives --install \
    /usr/bin/gcc gcc /root/aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-gcc 10010 \
    --slave /usr/bin/g++ g++ /root/aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-g++
