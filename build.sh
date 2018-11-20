#!/bin/sh
#
# build.sh
# pulls down the latest jenkinsci build, tweaks the dockerfile, then 
# runs the build and pushes to hub.docker.com
#

ARCH=`arch`
echo -e "\033[1;35mPlatform is $ARCH\033[0m"
echo -e "\033[1;36mBuilding latest-alpine\033[0m"
docker build -t wroney/rpi-mpich-alpine-$ARCH:latest -f Dockerfile-alpine .
docker push wroney/rpi-mpich-alpine-$ARCH:latest

