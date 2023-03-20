#!/bin/bash

(which jq 2>/dev/null |grep -q jq ) || ( which apk 2>/dev/null && ( apk add --no-cache procps psutils jq git date  ))
(which jq 2>/dev/null |grep -q jq ) || ( which apt 2>/dev/null && ( apt update ; apt install -y  jq git   ))

 which apk 2>/dev/null && (  
apk add date psutils procps bash 
#shadow 
sed 's~/ash$~/bash~g' -i /etc/passwd
)

(which docker-squash 2>/dev/null |grep -q docker-squash ) || ( which apk 2>/dev/null && ( apk add --no-cache py3-pip && pip3 install docker-squash ))
(which docker-squash 2>/dev/null |grep -q docker-squash ) || ( which apt 2>/dev/null && ( apt update ; apt install -y python3-pip ;pip3 install docker-squash ))

