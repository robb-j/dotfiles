FROM golang:1.17-alpine as golang
FROM node:18-alpine as nodejs
FROM alpine:3.15.0

ENV KUBE_VERSION=v1.23.4

RUN apk add --no-cache openssh git zsh zsh-vcs sudo curl kubectx gnupg libgcc python3 nano \
  && mkdir -p /home/user \
  && addgroup -g 1000 user \
  && adduser -D -u 1000 -G user -s /bin/zsh user \
  && passwd -u user \
  
  && touch /etc/ssh/ssh_host_rsa_key \
  && touch /etc/ssh/ssh_host_dsa_key \
  
  && chmod 600 /etc/ssh/ssh_host_rsa_key \
  && chmod 600 /etc/ssh/ssh_host_dsa_key \
  
  && curl -Lo /usr/local/bin/kubectl https://dl.k8s.io/release/${KUBE_VERSION}/bin/linux/amd64/kubectl \
  && chmod +x /usr/local/bin/kubectl \
  
  && mkdir -p /usr/local/go \
  && chown user:user /usr/local/go
  
COPY ["sshd_config", "/etc/ssh/sshd_config"]
COPY ["entrypoint.sh", "/entrypoint.sh"]
COPY ["motd", "/etc/motd"]
COPY --from=golang ["/usr/local/go/bin/", "/usr/local/bin"]
COPY --from=nodejs ["/usr/local/bin/", "/usr/local/bin"]
COPY --from=nodejs ["/usr/local/lib/node_modules/", "/usr/local/lib/node_modules"]

WORKDIR /home/user/
USER user

COPY --chown=user:user ["zshrc", "/home/user/.zshrc"]
COPY --chown=user:user ["zprofile", "/home/user/.zprofile"]

RUN mkdir .ssh \
  && touch .ssh/known_hosts \
  && touch .ssh/authorized_keys \
  
  && ssh-keyscan github.com > .ssh/known_hosts


USER root
EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D", "-e"]
