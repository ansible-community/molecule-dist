FROM python:3.8-slim-buster
# see https://pythonspeed.com/articles/base-image-python-docker-images/
LABEL maintainer="Ansible <info@ansible.com>"

ENV PACKAGES="\
bash \
docker \
git \
gcc \
rsync \
libyaml-dev \
"

ENV PIP_INSTALL_ARGS="--pre"
ENV PYTHONDONTWRITEBYTECODE=1

RUN \
apt update && \
apt install -y ${PACKAGES} && \
apt-get autoclean

COPY requirements.txt /tmp/requirements.txt

RUN \
python3 -m pip install \
${PIP_INSTALL_ARGS} -r /tmp/requirements.txt && \
rm -rf /root/.cache && \
molecule --version && \
molecule drivers && \
python3 -m pip check
# running molecule commands adds a minimal level fail-safe about build success

ENV SHELL /bin/bash
