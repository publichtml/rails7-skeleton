# https://docs.docker.jp/engine/examples/running_ssh_service.html

# $ docker build -t eg_sshd .
# $ docker run -d --rm -it -p 5000:22 --name test_sshd eg_sshd
#
# $ ssh root@localhost -p 5000
# (パスワードは screencast)
#
# $ docker stop test_sshd


# ssh 関連
FROM ubuntu:14.04

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# cap 関連
RUN apt-get install -y git

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
