FROM debian:buster-slim

LABEL maintainer="github.com/lucas-fs"

ENV PROJECT=/project

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    make \
    texlive-base \
    latexmk \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p $PROJECT

RUN useradd -u 1000 latex

WORKDIR $PROJECT

USER latex

CMD ["bash"]