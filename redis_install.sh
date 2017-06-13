#!/bin/bash

set -x
redisconf_path="/etc/redis/"
redisdata_path="/data/database/redis/"
redisservice_path="/etc/init.d/redis-server-6379"
### install depends software
apt-get install -y \
	wget \
	make \
	gcc \
	tcl
wget http://download.redis.io/releases/redis-2.8.17.tar.gz && \
	tar zxvf redis-2.8.17.tar.gz && \
	rm -rf redis-2.8.17.tar.gz
### compile and install
cd redis-2.8.17 && make MALLOC=libc && make test && make install && cd ..
### new conf file and the start shell scripts
if [ ! -d "$redisconf_path" ]; then
        mkdir -p "$redisconf_path"
fi
cp ./redis-6379.conf $redisconf_path/redis-6379.conf
local_ip=`ifconfig |grep "inet addr" |awk -F ":" '{print $2}' |awk -F " " '{print $1}' |head -1`
sed -i “s/10.173.224.8/$local_ip/g” $redisconf_path/redis-6379.conf

if [ ! -f "$redisservice_parh" ]; then
	touch "$redisservice_path"
fi
cat ./redis-server-6379 > /etc/init.d/redis-server-6379 && chmod a+x /etc/init.d/redis-server-6379
### new group and user
grep "redis" /etc/group >& /dev/null
if [ $? -ne 0 ];then
	groupadd redis
fi
if [ ! -d "$redisdata_path" ]; then
	mkdir -p "$redisdata_path/redisdata"
fi
grep "redis" /etc/passwd >& /dev/null
if [ $? -ne 0 ];then
	useradd redis
fi
usermod -s /bin/false -d /data/database/redis -g redis redis
chown -R redis.redis /data/database/redis
### start the service
service redis-server-6379 start
netstat -tnpl |grep redis >& /dev/null
if [[ $? -ne 0 ]]; then
	echo "the redis service is not running,and you should check the redis conf"
else
	echo "the redis service is running"
	echo "the installing process finished"
fi
