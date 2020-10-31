FROM alpine:edge
LABEL maintainer="Ansible <info@ansible.com>"

ENV PACKAGES="\
ansible \
docker \
git \
openssh-client \
docker-py \
libvirt \
libsodium \
rsync \
py3-bcrypt \
py3-botocore \
py3-certifi \
py3-cffi \
py3-chardet \
py3-click \
py3-colorama \
py3-cryptography \
py3-docutils \
py3-flake8 \
py3-idna \
py3-jinja2 \
py3-mccabe \
py3-netifaces \
py3-paramiko \
py3-pbr \
py3-pip \
py3-pluggy \
py3-psutil \
py3-ptyprocess \
py3-py \
py3-pycodestyle \
py3-pynacl \
py3-pytest \
py3-requests \
py3-ruamel \
py3-setuptools \
py3-urllib3 \
py3-virtualenv \
py3-websocket-client \
python3 \
"

# ENV BUILD_DEPS="\
# gcc \
# libc-dev \
# libvirt-dev \
# make \
# "

ENV PIP_INSTALL_ARGS="--pre"

RUN \
apk add --update --no-cache \
${BUILD_DEPS} ${PACKAGES} \
&& apk del --no-cache ${BUILD_DEPS} \
&& rm -rf /root/.cache

COPY requirements.txt /tmp/requirements.txt

RUN \
python3 -m pip install \
${PIP_INSTALL_ARGS} -r /tmp/requirements.txt && \
molecule --version && \
molecule drivers && \
python3 -m pip check
# running molecule commands adds a minimal level fail-safe about build success

ENV SHELL /bin/bash
