FROM alpine:3.11

ENV REVIEWDOG_VERSION=v0.9.17

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# hadolint ignore=DL3006
RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b /usr/local/bin/ "${REVIEWDOG_VERSION}"

RUN wget_gh() { mkdir "${4:-$2}" && wget -O - -q "https://github.com/$1/$2/archive/${3:-master}.tar.gz" | tar -C "${4:-$2}" -xz --strip-components=1; }; \
  apk --no-cache add vim && \
  mkdir -p /opt/vim && cd /opt/vim && \
    wget_gh ynkdir vim-vimlparser master vimlparser && \
    wget_gh syngan vim-vimlint master vimlint && \
  :

COPY entrypoint.sh /opt/gh-action-entrypoint.sh

ENTRYPOINT ["/opt/gh-action-entrypoint.sh"]
# vim:et:sw=2:sts=2:sta:tw=0
