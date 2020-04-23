#!/usr/bin/env bash

WHITE_COLOR_CODE='\033[0;37m'
GREEN_COLOR_CODE='\033[0;32m'

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

function show_section_title() {
  echo -e "${GREEN_COLOR_CODE}\\n[----- $1 -----]\\n${WHITE_COLOR_CODE}"
}

function replace_env_vars_in_template_and_copy_to_java_resources() {
  fix_multiline_env_bars
  template=scripts/google-cloud-service-account-template.json
  java_resource_file=src/main/resources/google-cloud-service-account.json
  envsubst < $template > $java_resource_file
}

function fix_multiline_env_bars() {
  key=$(echo "$GC_SVC_ACCT_PRIVATE_KEY_BASE64" | base64 --decode)
  export GC_SVC_ACCT_PRIVATE_KEY=$key
}

function build_project() {
  show_section_title "building project"
  ./gradlew clean build
}

function deploy() {
  show_section_title "deploying to PWS"
  cf push \
    --var db-url="${DB_URL}" \
    --var db-user="${DB_USER}" \
    --var db-password="${DB_PASSWORD}"
}

function main() {
  set_bash_fail_on_error
  go_to_root_directory
  replace_env_vars_in_template_and_copy_to_java_resources
  build_project
  deploy
}

main "$@"
