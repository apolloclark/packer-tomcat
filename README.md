# packer-tomcat

Gradle, Packer, Ansible, Serverspec, project to create Tomcat Docker images for
Ubuntu 18.04 Bionic LTS, Ubuntu 16.04 Xenial LTS, Debian 10 Buster, Debian 9 Stretch,
RHEL 8 UBI, RHEL 7 UBI, CentOS 7, and Amazon Linux 2 / Amazon Corretto.

## Requirements

- [Gradle](https://gradle.org/install/#manually)
- [Packer](https://packer.io/)
- [Ansible](https://www.ansible.com/)
- [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
    - [Serverspec](https://serverspec.org/): gem install serverspec
    - [docker-api](https://github.com/swipely/docker-api/releases): gem install docker-api



## Install
```shell
git clone --recurse-submodules https://github.com/apolloclark/packer-tomcat
cd ./packer-tomcat

# update submodules
git submodule update --recursive --remote
```


## Deploy to Docker
```
# set your Docker hub username
export DOCKER_USERNAME="apolloclark" # $(whoami)

# inspect the Official Tomcat Docker images
docker inspect tomcat:9-jdk11-openjdk | jq '.[].Config'

# clean up ALL previous builds
./clean_packer_docker.sh

# Gradle, clean up previous builds, from today
gradle clean --parallel --project-dir gradle-build

# Gradle, build all images, in parallel
gradle test --rerun-tasks --parallel --project-dir gradle-build

# Gradle, build only specific OS images
gradle ubuntu18.04:test --project-dir gradle-build --rerun-tasks
gradle ubuntu16.04:test --project-dir gradle-build --rerun-tasks
gradle debian10:test    --project-dir gradle-build --rerun-tasks
gradle debian9:test     --project-dir gradle-build --rerun-tasks

gradle rhel8:test     --project-dir gradle-build --rerun-tasks
gradle rhel7:test     --project-dir gradle-build --rerun-tasks
gradle centos7:test   --project-dir gradle-build --rerun-tasks
gradle amzlinux2:test   --project-dir gradle-build --rerun-tasks

gradle test --parallel --max-workers 4 --project-dir gradle-build

# Gradle, publish images
gradle push --parallel --max-workers 4 --project-dir gradle-build

# Gradle, list tasks, and dependency graph
gradle tasks --project-dir gradle-build
gradle tasks --all --project-dir gradle-build
gradle test taskTree --project-dir gradle-build

# Gradle, debug
gradle properties
gradle ubuntu16.04:info --project-dir gradle-build
gradle ubuntu16.04:test --project-dir gradle-build --info --rerun-tasks
rm -rf ~/.gradle
```



## Build Details

```shell
OpenJDK, 11.0.4, 2019-07-16
https://github.com/AdoptOpenJDK/openjdk11-upstream-binaries/releases/

Tomcat, 9.0.22, 2019-07-04
https://github.com/apache/tomcat/releases
```