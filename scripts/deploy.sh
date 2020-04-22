#!/usr/bin/env bash

function set_bash_fail_on_error() {
  set -o errexit
  set -o errtrace
  set -o nounset
  set -o pipefail
}

function go_to_root_directory() {
  root_directory=$(git rev-parse --show-toplevel)
  cd "$root_directory"
}

function build_project() {
  ./gradlew clean build
}

function deploy() {
  cf push \
    --var db-url="${DB_URL}" \
    --var db-user="${DB_USER}" \
    --var db-password="${DB_PASSWORD}"
}

function main() {
  set_bash_fail_on_error
  go_to_root_directory
  build_project
  deploy
}

main "$@"
