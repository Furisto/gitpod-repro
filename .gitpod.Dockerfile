FROM ubuntu:22.04

RUN apt-get update && apt-get install -y sudo podman git runc strace curl docker.io nano crun
RUN addgroup --gid 33333 gitpod \
  && adduser --home /home/gitpod --disabled-login --shell /bin/bash --gid 33333 --uid 33333 gitpod \
  && echo '%gitpod ALL=NOPASSWD:ALL' >> /etc/sudoers

ENV CONTAINERS_STORAGE_CONF="/workspace/gitpod-repro/storage.conf"