# MorelloIE Docker Images

This repo contains my Dockerfiles for creating some non-official MorelloIE docker images:

- cocoaxu/morelloie-llvm
- cocoaxu/morelloie-gcc

They contain the LLVM- and GCC-toolchain for the CHERI system, respectively. You can use them to compile your CHERI programs on your non-CHERI platform.

## Build
```bash
docker build -f Dockerfile.llvm . -t cocoaxu/morelloie-llvm
docker build -f Dockerfile.gcc . -t cocoaxu/morelloie-gcc
```

## Run
For example, if your source code is in `/home/user/src`, you can do the following:

```shell
# using LLVM toolchain with musl libc
$ docker run -it --rm --volume /home/user/src:/src cocoaxu/morelloie-llvm

# using GCC toolchain with glibc
$ docker run -it --rm --volume /home/user/src:/src cocoaxu/morelloie-gcc
```

Then you can compile your CHERI programs inside the container. Inside these Docker images,
they both have `morelloie` pre-installed while the CHERI compiler is `clang` and `gcc`,
respectively. 
  
And for the LLVM toolchain specificly, a sysroot directory for Purecap can be found at 
`/root/musl-sysroot-purecap`, which can be used later when compiling Purecap Morello programs
with `clang`.

- If you're using the LLVM Docker image, ``cocoaxu/morelloie-llvm``, then the 
  CHREI compiler is ``clang``, and we need to specify the target as 
  ``aarch64-linux-musl_purecap`` and the sysroot as ``/root/musl-sysroot-purecap``:

  ```shell
  $ clang -march=morello \
      --target=aarch64-linux-musl_purecap \
      --sysroot=/root/musl-sysroot-purecap \
      test.c -o test -static
  ```

- If you're using the GCC Docker image, ``cocoaxu/morelloie-gcc``, then we can compile
  the program with ``gcc`` and we don't need to specify the target or sysroot:

  ```shell
  $ gcc -march=morello+c64 -mabi=purecap \
      test.c -o test -static
  ```

After the compilation, you need to run the program with ``morelloie``. For example:

```shell
$ morelloie -- ./test
```
