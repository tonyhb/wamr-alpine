FROM alpine:3.13 AS base

RUN apk add -U g++ cmake make libgcc git python3
RUN git clone https://github.com/bytecodealliance/wasm-micro-runtime.git /src
WORKDIR src
RUN git checkout WAMR-04-15-2021

FROM base AS wamrc
WORKDIR /src/wamr-compiler
RUN ./build_llvm.sh
RUN mkdir build
WORKDIR /src/wamr-compiler/build
RUN cmake .. && make

FROM base AS iwasm

WORKDIR /src/product-mini/platforms/linux/
RUN mkdir build
WORKDIR /src/product-mini/platforms/linux/build
RUN cmake .. && make
