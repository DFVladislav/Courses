#!/usr/bin/env bash
set -euo pipefail

cd /mnt/c/Users/fedya/courses

DOCKER="/mnt/c/Users/fedya/AppData/Local/Programs/DockerDesktop/resources/bin/docker.exe"

"$DOCKER" exec -e MYSQL_PWD=123 my-mysql \
  mysql -uroot -e "SET GLOBAL general_log='OFF';"

"$DOCKER" cp my-mysql:/var/lib/mysql/general.log ./general.log

"$DOCKER" exec -e MYSQL_PWD=123 my-mysql \
  mysqldump -uroot index_practice > index_dump.sql

"$DOCKER" exec -e MYSQL_PWD=123 my-mysql \
  mysqldump -uroot \
  --set-gtid-purged=OFF \
  --single-transaction \
  --databases index_practice > index_dump_clean.sql

python3 scripts/filter_general_log.py general.log my_actions.log

"$DOCKER" exec -e MYSQL_PWD=123 my-mysql \
  mysql -uroot -e "SET GLOBAL general_log='ON'; SET GLOBAL log_output='FILE'; SET GLOBAL general_log_file='/var/lib/mysql/general.log';"
