FROM rust:1.29-stretch

RUN apt update -y && \
    apt install -y gcc-arm-linux-gnueabihf libc6-armhf-cross && \
    apt clean

RUN rustup target add armv7-unknown-linux-gnueabihf

RUN curl -L -o /usr/src/libusb-1.0-0_1.0.21-1_armhf.deb http://ftp.it.debian.org/debian/pool/main/libu/libusb-1.0/libusb-1.0-0_1.0.21-1_armhf.deb && \
    ar p /usr/src/libusb-1.0-0_1.0.21-1_armhf.deb data.tar.xz | tar JxC / && \
    rm -f /usr/src/libusb-1.0-0_1.0.21-1_armhf.deb

RUN curl -L -o /usr/src/libusb-1.0-0-dev_1.0.21-1_armhf.deb http://ftp.it.debian.org/debian/pool/main/libu/libusb-1.0/libusb-1.0-0-dev_1.0.21-1_armhf.deb && \
    ar p /usr/src/libusb-1.0-0-dev_1.0.21-1_armhf.deb data.tar.xz | tar JxC / && \
    rm -f /usr/src/libusb-1.0-0-dev_1.0.21-1_armhf.deb

RUN curl -L -o /usr/src/libssl-dev_1.1.0f-3+deb9u1_armhf.deb http://ftp.it.debian.org/debian/pool/main/o/openssl/libssl-dev_1.1.0f-3+deb9u2_armhf.deb && \
    ar p /usr/src/libssl-dev_1.1.0f-3+deb9u1_armhf.deb data.tar.xz | tar JxC / && \
    rm -f /usr/src/libssl-dev_1.1.0f-3+deb9u1_armhf.deb


RUN curl -L -o /usr/src/libudev1_232-25+deb9u1_armhf.deb http://ftp.it.debian.org/debian/pool/main/s/systemd/libudev1_232-25+deb9u4_armhf.deb && \
    ar p /usr/src/libudev1_232-25+deb9u1_armhf.deb data.tar.xz | tar JxC / && \
    rm -f /usr/src/libudev1_232-25+deb9u1_armhf.deb

ENV RUST_TARGETS "armv7-unknown-linux-gnueabihf"
ENV PKG_CONFIG_PATH "/usr/lib/arm-linux-gnueabihf/pkgconfig"
ENV PKG_CONFIG_ALLOW_CROSS "1"
ENV CARGO_HOME "/opt/cargo"

ADD cargo-config /opt/cargo/config
ADD gcc-sysroot /usr/local/bin

WORKDIR /build

CMD ["cargo", "build"]