#!/usr/bin/env bash

export MYSQL_PWD="${MYSQL_PWD:-123}"

docker() {
  "/mnt/c/Users/fedya/AppData/Local/Programs/DockerDesktop/resources/bin/docker.exe" "$@"
}
