# dind on python:3.9-slim-buster
Docker container for running docker-in-docker on Debian Buster with Python 3.9.

The official Docker Library for [dind](https://hub.docker.com/_/docker/) is based off of Alpine Linux and difficult to develop on.

Because of this, domofactor wrote this an image which uses Debian Jessie instead (see https://github.com/domofactor/dind-jessie).
This fork uses Debian Buster with Python 3.9, using the official Docker image `python:3.9-slim-buster`.

## Usage

Due to the nature of using docker-in-docker, this container requires the `--privileged` flag to be passed.

It can be started with the following syntax:

`docker run --privileged -it r-bird/dind-jessie`

If you'd like to pass a custom CMD such as `/bin/bash` for example, you can do that with:

`docker run --privileged -it r-bird/dind-jessie /bin/bash`

### Environment Variables

The following env vars are supported:
|:--------------------:|:-----------:|:-------:|
| Environment Variable | Description | Default |
`DOCKER_EXTRA_OPTS`| options to pass to the dockerd daemon | `--storage-driver=overlay`|

#### Example
`docker run --privileged -e DOCKER_EXTRA_OPTS=--storage-driver=aufs -it r-bird/dind-jessie`

### Build Arguments

the following build args are supported:
|:--------------------:|:-----------:|:-------:|
| Argument | Description | Default |
|DOCKER_CHANNEL|the channel to use for install docker: `stable`,`edge`|`stable`|
|DOCKER_VERSION|the version of docker to install|`20.10.8`|
|DOCKER_COMPOSE_VERSION|the version of docker-compose to install|`1.29.2`|
|DIND_COMMIT|the long commit-sha of the dind script to be installed|`deda3d4933d3c0bd57f2cef672da5d28fc653706`|

#### Example
``docker build --build-arg DOCKER_VERSION=20.10.8 --build-arg DOCKER_CHANNEL=stable .``
