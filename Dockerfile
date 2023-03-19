ARG BUILDX_VERSION=0.10.4
ARG DOCKER_VERSION=latest

FROM alpine AS fetcher

RUN apk add curl bash 

ARG BUILDX_VERSION
ARG DOCKER_VERSION
COPY setup.sh /
RUN /bin/bash /setup.sh


FROM docker:${DOCKER_VERSION}

COPY --from=fetcher /docker-buildx /usr/lib/docker/cli-plugins/docker-buildx
COPY --from=fetcher /regctl /usr/lib/docker/cli-plugins/regctl
COPY --from=fetcher /regbot /usr/lib/docker/cli-plugins/regbot
COPY --from=fetcher /regsync /usr/lib/docker/cli-plugins/regsync

RUN apk add curl bash git jq skopeo 

RUN (test -e /etc/scripts||mkdir /etc/scripts) || true 
RUN git clone https://gitlab.com/the-foundation/docker-squash-multiarch.git /etc/scripts/docker-squash-multiarch
RUN ln -s /etc/scripts/docker-squash-multiarch/docker-squash-multiarch.sh /usr/bin/docker-squash-multiarch
RUN chmod +x /etc/scripts/docker-squash-multiarch/docker-squash-multiarch.sh || true 

RUN for thingy in regctl regbot regsync skopeo ;do which "$thingy";done