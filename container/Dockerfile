FROM node:16-alpine as node


FROM alpine:3

RUN apk add --no-cache openssh git \
  && mkdir -p user \
  && addgroup -g 1000 user \
  && adduser -D -u 1000 -G user -s /bin/sh user \
  && passwd -u user \
  && chown -R user:user /home/user

WORKDIR /home/user/

RUN mkdir .ssh \
  && chmod 0700 .ssh \
  && touch .ssh/authorized_keys && chmod 0600 .ssh/authorized_keys \
  && chown -R user:user .ssh \
  && touch /etc/ssh/ssh_host_rsa_key \
  && touch /etc/ssh/ssh_host_dsa_key \
  && chmod 600 /etc/ssh/ssh_host_rsa_key \
  && chmod 600 /etc/ssh/ssh_host_dsa_key

COPY ["sshd_config", "/etc/ssh/sshd_config"]
COPY ["entrypoint.sh", "/entrypoint.sh"]

EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D", "-e"]