# based on https://github.com/leifgehrmann/docker-autotrace
FROM debian:bookworm-slim

# 1. Fetch new versions of packages.
# 2. Fetch `build-essentials`, so we can use `Make`.
# 3. Fetch `autotrace` dependencies (See `autotrace`'s GitHub action), without unnecessary dependencies (`--no-install-recommends`).
# 4. Clean and remove package manager cache.
RUN apt-get update \
 && apt-get -y install build-essential \
 && apt-get -y install libgraphicsmagick1-dev libpng-dev libexiv2-dev libtiff-dev libjpeg-dev libxml2-dev libbz2-dev libfreetype6-dev libpstoedit-dev autoconf automake libtool intltool autopoint time --no-install-recommends \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Copy the sources into the container image.
COPY . /autotrace
WORKDIR /autotrace

# 1. Follow the instructions in `autotrace`'s GitHub action.
# 2. Finally, run the check to confirm everything was properly installed.
RUN ./autogen.sh \
 && ./configure \
 && make \
 && make check

ENTRYPOINT ["/autotrace/autotrace"]

