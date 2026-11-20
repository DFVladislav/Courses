#!/usr/bin/env bash
set -e

source /mnt/c/Users/fedya/courses/scripts/wsl_aliases.sh
cd /mnt/c/Users/fedya/courses

docker ps --filter name=my-mysql --format '{{.Names}} {{.Status}}'
docker exec -e MYSQL_PWD="$MYSQL_PWD" my-mysql mysql -uroot --table -D index_practice \
  -e "EXPLAIN SELECT * FROM orders WHERE amount > 1000;"
