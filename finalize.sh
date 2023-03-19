#!/bin/bash
(which docker-squash 2>/dev/null |grep -q docker-squash ) || (which apk && ( apk add --no-cache py3-pip && pip3 install docker-squash ))
(which docker-squash 2>/dev/null |grep -q docker-squash ) || ( which apt && ( apt update ; apt install -y python3-pip ;pip3 install docker-squash ))
