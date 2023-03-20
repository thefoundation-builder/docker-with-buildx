ARG BUILDX_VERSION=0.10.4
ARG DOCKER_VERSION=latest

FROM alpine AS fetcher

RUN apk add curl bash 

ARG BUILDX_VERSION
ARG DOCKER_VERSION
COPY setup.sh /root/.setup.sh
RUN /bin/bash /root/.setup.sh

## FAILED: docker:latest is only aarch64 and amd64
#FROM docker:${DOCKER_VERSION}
FROM alpine
RUN apk add curl  sed grep date jq bash curl bind-tools git bash jq procps date bash docker docker-compose docker-cli ca-certificates ip6tables py3-pip skopeo
COPY --from=fetcher /docker-buildx /usr/lib/docker/cli-plugins/docker-buildx
COPY --from=fetcher /regctl /usr/lib/docker/cli-plugins/regctl
COPY --from=fetcher /regbot /usr/lib/docker/cli-plugins/regbot
COPY --from=fetcher /regsync /usr/lib/docker/cli-plugins/regsync

RUN (test -e /etc/scripts||mkdir /etc/scripts) || true 
RUN git clone https://gitlab.com/the-foundation/docker-squash-multiarch.git /etc/scripts/docker-squash-multiarch
RUN ln -s /etc/scripts/docker-squash-multiarch/docker-squash-multiarch.sh /usr/bin/docker-squash-multiarch
RUN chmod +x /etc/scripts/docker-squash-multiarch/docker-squash-multiarch.sh || true 
COPY finalize.sh /root/.finalize.sh
RUN /bin/bash    /root/.finalize.sh
RUN for thingy in regctl regbot regsync skopeo docker-squash ;do which "$thingy";done
