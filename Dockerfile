FROM debian:13.1@sha256:fd8f5a1df07b5195613e4b9a0b6a947d3772a151b81975db27d47f093f60c6e6

RUN apt-get update &&\
    apt-get -y install --no-install-recommends bzip2 xz-utils zip unzip tar \
            wget ca-certificates git curl dnsutils nethogs \
            bash zsh &&\
    apt-get -y clean && rm -rf /var/lib/apt/lists/*

ARG KUBECTL_ARCH="amd64"
# renovate: datasource=github-tags depName=kubernetes/kubernetes versioning=semver
ARG KUBECTL_VERSION="v1.34.1"
RUN curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${KUBECTL_ARCH}/kubectl" &&\
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

WORKDIR /workdir

RUN set -eux; \
    groupadd -g 1000 devops; \
    useradd -u 1000 -g 1000 -s /bin/sh -m -b /home/devops devops

RUN chown -R devops:devops /workdir

USER devops

ENTRYPOINT [ "sh" ]
CMD [ "" ]
