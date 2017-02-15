FROM alpine
RUN apk --no-cache add \
      bash \
      bash-completion \
      groff \
      less \
      curl \
      jq \
      py-pip \
      python \
      openssh &&\
    pip install --upgrade \
      awscli \
      pip \
      python-dateutil &&\
    ln -s /usr/bin/aws_bash_completer /etc/profile.d/aws_bash_completer.sh &&\
    mkdir ~/.aws &&\
    chmod 700 ~/.aws

VOLUME ["~/.aws"]
ENTRYPOINT ["aws"]
