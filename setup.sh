#!/bin/bash
export BUILD_ARCH=$(uname -m |grep aarch64 -q && echo arm64 ; uname -m |grep -q -e amd64 -e amd_64 -e x86_64 && echo amd64 ;  uname -m |grep -q -e i386 -e i686 -e ia32 && echo i386 )
echo "DETECTED BUILD_ARCH : $BUILD_ARCH"
export BUILDX_VERSION=$(curl -s "https://github.com/docker/buildx/releases"|grep expanded_assets|grep 'src="https://github.com/'|sed 's/.\+expanded_assets\/v//g;s/".\+//g'|head -n1)
export REGCTL_VERSION=$(curl -s "https://github.com/regclient/regclient/releases"|grep expanded_assets|grep 'src="https://github.com/'|sed 's/.\+expanded_assets\/v//g;s/".\+//g'|head -n1)


[[ -z "$BUILDX_VERSION" ]] && export BUILDX_VERSION=0.10.4

##fetch em 
curl -L \
  --output /docker-buildx \
  "https://github.com/docker/buildx/releases/download/v${BUILDX_VERSION}/buildx-v${BUILDX_VERSION}.linux-${BUILD_ARCH}" && chmod a+x /docker-buildx

for thingy in regctl regbot regsync;do 
curl -L \
  --output "/$thingy" \
  "https://github.com/regclient/regclient/releases/download/v${REGCTL_VERSION}/${thingy}-v${REGCTL_VERSION}.linux-${BUILD_ARCH}" && chmod a+x "/$thingy"
done


ls -lh1 /docker-buildx  /regctl /regsync /regbot || exit 1
