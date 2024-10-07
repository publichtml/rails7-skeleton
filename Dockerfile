ARG RUBY_VERSION=3.3.5
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# ssh 関連
RUN apt-get update && apt-get install -y openssh-server vim
RUN mkdir /var/run/sshd
# NOTE: root の password は `screencast`
RUN echo 'root:screencast' | chpasswd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

# cap, rails 関連
ENV CAPISTRANO_ROOT_DIR "/var/www/app"

WORKDIR $CAPISTRANO_ROOT_DIR

RUN apt-get install --no-install-recommends -y build-essential git curl sudo sqlite3

COPY .env "${CAPISTRANO_ROOT_DIR}/shared/.env"
COPY puma.rb "${CAPISTRANO_ROOT_DIR}/shared/puma.rb"
COPY config/database.yml "${CAPISTRANO_ROOT_DIR}/shared/config/database.yml"


EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
