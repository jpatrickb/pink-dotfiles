# Mimics the cluster: Rocky 9 (glibc 2.34), bash login shell, git/curl/tmux/zsh
# present, NO sudo, unprivileged user.
FROM rockylinux:9
RUN dnf -y -q install git tar xz gzip tmux zsh gawk findutils which procps-ng && dnf clean all
RUN useradd -m -s /bin/bash thea
USER thea
WORKDIR /home/thea
