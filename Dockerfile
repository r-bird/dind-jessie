FROM python:3.9-slim-buster

############
## Docker ##
############
ARG DOCKER_CHANNEL=stable
ARG DOCKER_VERSION=20.10.8

RUN apt-get update && apt-get install -y --no-install-recommends \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   ${DOCKER_CHANNEL}"
RUN apt-get update && apt-get install -y --no-install-recommends docker-ce=5:${DOCKER_VERSION}~3-0~debian-buster && \
  docker -v && \
  dockerd -v

####################
## Docker Compose ##
####################
ARG DOCKER_COMPOSE_VERSION=1.29.2
RUN curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose

#################
## DIND Script ##
#################
ARG DIND_COMMIT=deda3d4933d3c0bd57f2cef672da5d28fc653706
ENV DOCKER_EXTRA_OPTS '--storage-driver=overlay'
RUN curl -fL -o /usr/local/bin/dind "https://raw.githubusercontent.com/moby/moby/${DIND_COMMIT}/hack/dind" && \
	chmod +x /usr/local/bin/dind


################
## Entrypoint ##
################
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh


VOLUME /var/lib/docker
EXPOSE 2375
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
