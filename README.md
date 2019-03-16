# packer-tomcat

Packer, Ansible, Serverspec, project to create an Tomcat images.

## Requirements

- Packer
- Ansible
- [Serverspec](https://serverspec.org/): gem install serverspec
- [docker-api](https://github.com/swipely/docker-api/releases): gem install docker-api

## Install
```shell
git clone https://github.com/apolloclark/packer-tomcat
cd ./packer-tomcat

# set your Docker hub username
export DOCKER_USERNAME="apolloclark" # $(whoami)

# build the container image
./build_packer_docker.sh

# run the container image, allowing it to control the Host
docker run -it $DOCKER_USERNAME/tomcat /bin/bash -


```

## Build Details

```shell
OpenJDK, 11.0.2, 2019-02-20
https://jdk.java.net/11/

Tomcat, 9.0.16, 2019-02-04
https://github.com/apache/tomcat/releases
```