#!/bin/bash -eux

# ensure that ENV VARs are set
export DOCKER_USERNAME=${DOCKER_USERNAME:=$(whoami)}
export PACKAGE=${PACKAGE:=tomcat}
export PACKAGE_VERSION=${PACKAGE_VERSION:="9.0.16"}
export BASE_IMAGE=${BASE_IMAGE:="apolloclark/openjdk:11.0.2-ubuntu16.04"}
export IMAGE_NAME=${IMAGE_NAME:="ubuntu16.04"}

./build_packer_docker.sh
