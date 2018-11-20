# pi-mpich
MPICH for running on a Raspberry PI cluster (based off NLKNguyen/alpine-mpich)


This repo, running build.sh, updates the jenkinsci/docker and then runs a build.  It generates images for all three flavors with -$ARCH in the tag:
- wroney/rpi-mpich-alpine-$ARCH:latest

On a 32 bit Pi environment, arch is arm7l, under 64 bit for a Pi3 the arch is aarch64.  Three manifest yamls are provided for use with [estesp/manifest-tool](https://github.com/estesp/manifest-tool).  This allows multi-arch manifesting for the two images as:
- wroney/rpi-mpich-alpine:latest

>./manifest-tool push from-spec manifest-alpine.yaml
