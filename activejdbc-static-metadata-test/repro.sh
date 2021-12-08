#!/bin/zsh
set -ex

docker run --rm --name mariadb-test -d -p 33060:3306 -e MYSQL_ROOT_PASSWORD=password mariadb:10.5
sleep 1
docker exec mariadb-test mysql -h 127.0.0.1 -u root -ppassword -e "CREATE DATABASE IF NOT EXISTS test; use test; create table test(id int  null, foo varchar(256) null);"

mvn package -U

docker rm -f mariadb-test