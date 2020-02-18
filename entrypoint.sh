#!/bin/ash
set -e

if [ -n "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}" || exit
fi

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

tolower() {
  tr '[:upper:]' '[:lower]'
}
tobool() {
  str=$(printf '%s\n' "$1" | tolower)
  if [ 'xtrue' = "x$str" ]; then
    printf 'y\n'
  elif [ 'xfalse' = "x$str" ]; then
    printf 'n\n'
  else
    printf 'invalid boolean: %s\n' "$str" >&2 && return 2
  fi
}
bool_status() {
  bool=$(tobool "$@")
  rc=$?
  [ "$rc" != 0 ] && return "$rc"
  [ "$bool" = 'y' ] && return 0
  return 1
}

if bool_status "${INPUT_VERBOSE}"; then
  INPUT_FLAGS="-v ${INPUT_FLAGS}"
fi
if bool_status "${ONLY_ERROR}"; then
  INPUT_FLAGS="-E ${INPUT_FLAGS}"
fi

sh /opt/vim-vimlint/bin/vimlint.sh -l /opt/vim/vimlint -p /opt/vim/vimlparser \
    ${INPUT_FLAGS} ${INPUT_PATH:+"${INPUT_PATH}"} ${INPUT_PATHS} . \
  | reviewdog -name="vimlint" \
    -efm="%f:%l:%c:%trror: %m" -efm="%f:%l:%c:%tarning: %m" -efm="%f:%l:%c:%m" \
    -reporter="${INPUT_REPORTER:-github-pr-check}" -level="${INPUT_LEVEL}"

# vim:et:sw=2:sts=2:sta:tw=0:ff=unix
