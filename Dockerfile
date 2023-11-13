FROM ubuntu:latest
LABEL maintainer="Cocoa <i@uwucocoa.moe>"

WORKDIR /root
ENV MORELLOIE_DOWNLOAD_URL="https://developer.arm.com/-/media/Arm%20Developer%20Community/Downloads/Morello/Development%20Tools/Morello%20Instruction%20Emulator" \
    MORELLOIE_VERSION="2.3-533" \
    MORELLO_LLVM_VERSION="1.6.1" \
    MUSL_GITREF="morello/master" \
    MORELLOIE_PREFIX=/root/morelloie \
    LLVM_PREFIX=/root/llvm \
    MUSL_SOURCES=/root/musl \
    MUSL_PREFIX_PURECAP=/root/musl-sysroot-purecap \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/llvm/bin:/root/morelloie/bin \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get update -q=2 && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q=2 --yes \
        --no-install-recommends --no-install-suggests \
        curl git make sudo locales ca-certificates && \
    update-ca-certificates && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen

RUN cd /root && \
    rm -rf ${HOME}/morelloie-* ${MORELLOIE_PREFIX} && \
    curl -fSL "${MORELLOIE_DOWNLOAD_URL}/morelloie-${MORELLOIE_VERSION}.tgz.sh" -o "/root/morelloie-${MORELLOIE_VERSION}.tgz.sh" && \
    chmod a+x "/root/morelloie-${MORELLOIE_VERSION}.tgz.sh" && \
    /root/morelloie-${MORELLOIE_VERSION}.tgz.sh --i-agree-to-the-contained-eula --prefix=${MORELLOIE_PREFIX} && \
    rm -rf ${LLVM_PREFIX} && \
    mkdir -p ${LLVM_PREFIX} && \
    cd ${LLVM_PREFIX} && \
    git init && \
    repo=https://git.morello-project.org/morello/llvm-project-releases.git && \
    branch=morello/linux-aarch64-release-${MORELLO_LLVM_VERSION} && \
    git fetch -- ${repo} +refs/heads/${branch}:refs/remotes/origin/${branch} && \
    git checkout origin/${branch} -b ${branch} && \
    rm -rf ${MUSL_SOURCES} && \
    mkdir -p ${MUSL_SOURCES} && \
    cd ${MUSL_SOURCES} && \
    git init && \
    repo=https://git.morello-project.org/morello/musl-libc.git && \
    gitref=${MUSL_GITREF} && \
    git fetch -- ${repo} +refs/heads/${gitref}:refs/remotes/origin/${gitref} && \
    git checkout origin/${gitref} -b ${gitref} && \
    cd ${MUSL_SOURCES} && \
    make distclean && \
    CC=${LLVM_PREFIX}/bin/clang ./configure \
        --prefix=${MUSL_PREFIX_PURECAP} \
        --target=aarch64-linux-musl_purecap && \
    make -j`nproc` && \
    make install
   
