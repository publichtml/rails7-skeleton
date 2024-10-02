# https://docs.docker.jp/engine/examples/running_ssh_service.html

# $ docker build -t eg_sshd .
# $ docker run -d --rm -it -p 5000:22 --name test_sshd eg_sshd
#
# $ ssh root@localhost -p 5000
# (パスワードは screencast)
#
# $ docker stop test_sshd


ARG RUBY_VERSION=3.3.5
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# ssh 関連
RUN apt-get update && apt-get install -y openssh-server vim
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

# cap 関連
ENV CAPISTRANO_ROOT_DIR "/var/www/app"

RUN apt-get install -y git

COPY config/database.yml "${CAPISTRANO_ROOT_DIR}/shared/config/database.yml"


EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
