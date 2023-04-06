# docker image with buildx installed

## Features
**improved** version of https://github.com/jdrouet/docker-with-buildx.git

Includded binaries 

| Program |availability | 
|--|--|
| skopeo | all_arch |
| regclient aka [ regctl regsync regbot ]  | x6_64 + arm64v8 |
| docker-squash | all_arch |
| docker-squash-multiarch | all_arch |
| buildx | all_arch |
| gh   ( github CLI ) | all_arch |
| glab ( gitlab CLI ) | all_arch |


## Architectures: 

(note: builds might temporarily fallback to amd64/aarch64)

* i386
* amd64
* armv7
* aarch64



## build status

|Type|Status|
|--|--|
| Docker | ![Github Build](https://github.com/thefoundation-builder/docker-with-buildx/actions/workflows/build.yml/badge.svg) |

## docker tags
| Registry | Tag |
|--|--|
| quay.io (  MAIN  ) | `quay.io/thefoundation/library:docker-with-buildx`  |
| ghcr.io ( GITHUB ) | `ghcr.io/thefoundation-builder/docker-with-buildx:latest` |

---


#### ORIG README (jdrouet)

To build the image, you just have to run

```bash
docker build -t docker-with-buildx .
```
