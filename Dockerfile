FROM debian:sid-slim

WORKDIR /src

RUN apt-get update && \
    apt-get install -y -q --no-install-recommends ca-certificates build-essential cmake libffi-dev curl make python git gcc-avr binutils-avr gdb-avr avr-libc avrdude && \
    git clone https://github.com/avr-rust/rust.git && \
    mkdir build && \
    cd build && \
    ../rust/configure \
      --enable-debug \
      --disable-docs \
      --enable-llvm-assertions \
      --enable-debug-assertions \
      --enable-optimize \
      --prefix=/usr/local && \
    make && \
    make install && \
    cd .. && \
    rm -rf ./rust ./build /var/lib/apt/lists/* && \
    rm -rf ~/.cargo && \
    curl https://static.rust-lang.org/cargo-dist/cargo-nightly-x86_64-unknown-linux-gnu.tar.gz | tar -xz && \
    ./cargo-nightly-x86_64-unknown-linux-gnu/install.sh && \
    rm -rf ./cargo-nightly-x86_64-unknown-linux-gnu

COPY avr-rust.sh /usr/local/bin/avr-rust.sh

ENV TARGET=arduino \
    PARTNO=atmega328p \
    PROGRAMMER=arduino

VOLUME /src

ENTRYPOINT ["/usr/local/bin/avr-rust.sh"]
CMD ["compile"]
