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
RUN apk add curl sudo sed grep psmisc procps coreutils jq bash curl bind-tools git shadow procps openssh-client btrfs-progs e2fsprogs e2fsprogs-extra ip6tables iptables openssl shadow-uidmap xfsprogs xz pigz   docker-bash-completion cpulimit docker-compose docker-cli ca-certificates ip6tables py3-pip skopeo 
COPY --from=fetcher /docker-buildx /usr/lib/docker/cli-plugins/docker-buildx
COPY --from=fetcher /regctl  /usr/bin/regctl
COPY --from=fetcher /regbot  /usr/bin/regbot
COPY --from=fetcher /regsync /usr/bin/regsync

RUN chmod +x /usr/bin/regctl /usr/bin/regbot /usr/bin/regsync /usr/lib/docker/cli-plugins/docker-buildx 
RUN grep "^Not Found$" /usr/bin/regctl /usr/bin/regbot /usr/bin/regsync /usr/lib/docker/cli-plugins/docker-buildx && exit 1
RUN (test -e /etc/scripts||mkdir /etc/scripts) || true 
RUN git clone https://gitlab.com/the-foundation/docker-squash-multiarch.git /etc/scripts/docker-squash-multiarch
RUN ln -s /etc/scripts/docker-squash-multiarch/docker-squash-multiarch.sh /usr/bin/docker-squash-multiarch
RUN chmod +x /etc/scripts/docker-squash-multiarch/docker-squash-multiarch.sh || true 
COPY finalize.sh /root/.finalize.sh
RUN /bin/bash    /root/.finalize.sh
RUN echo checking for regctl regbot regsync skopeo docker-squash && for thingy in regctl regbot regsync skopeo docker-squash ;do which "$thingy" || exit 1 ;done 
VOLUME /var/lib/docker
EXPOSE 2375 2376
