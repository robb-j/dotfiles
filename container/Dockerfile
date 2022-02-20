FROM golang:1.17-alpine as golang
FROM alpine:3.15.0

ARG KUBE_VERSION=v1.23.4

RUN apk add --no-cache openssh git zsh sudo curl kubectx \
  && mkdir -p user \
  && addgroup -g 1000 user \
  && adduser -D -u 1000 -G user -s /bin/zsh user \
  && passwd -u user \
  
  && touch /etc/ssh/ssh_host_rsa_key \
  && touch /etc/ssh/ssh_host_dsa_key \
  
  && chmod 600 /etc/ssh/ssh_host_rsa_key \
  && chmod 600 /etc/ssh/ssh_host_dsa_key \
  
  && curl -Lo /usr/bin/kubectl https://dl.k8s.io/release/$KUBE_VERSION/bin/linux/amd64/kubectl \
  && chmod +x /usr/bin/kubectl \
  
  && mkdir -p /usr/local/go \
  && chown user:user /usr/local/go
  
COPY ["sshd_config", "/etc/ssh/sshd_config"]
COPY ["entrypoint.sh", "/entrypoint.sh"]
COPY ["motd", "/etc/motd"]
COPY --from=golang ["/usr/local/go/bin/go", "/usr/local/go/bin/gofmt", "/usr/bin"]

WORKDIR /home/user/
USER user

COPY --chown=user:user ["zshrc", "/home/user/.zshrc"]

RUN mkdir .ssh \
  # && chmod 0700 .ssh \
  && touch .ssh/known_hosts \
  && touch .ssh/authorized_keys \
  # && chmod 0600 .ssh/authorized_keys \
  # && chown -R user:user /home/user \
  
  && ssh-keyscan github.com > .ssh/known_hosts \
  
  && curl -fsSL https://fnm.vercel.app/install | zsh -s -- --skip-shell \
  && /home/user/.fnm/fnm install lts/gallium \
  && /home/user/.fnm/fnm default lts/gallium


USER root
EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D", "-e"]