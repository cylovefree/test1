#!/bin/bash

cd /data/logs/db_check_TCP_conSum 
mkdir -p processlist
mkdir -p db_connection

while [[ 1 ]]
do
       My_time=`date "+%Y-%m-%d %H:%M:%S"`
       My_file_time=$(date +%Y%m%d)
       My_yesterday=`date -d "-1day" "+%Y%m%d"`
       My_lastday=`date -d "-15day" "+%Y%m%d"` 

       echo -e "\n\n\n$My_time" >> $My_file_time-processlist.log
       mysql -h10.10.10.10 -utest -ptest -e "show full processlist;" >> $My_file_time-processlist.log
       if [[ -f $My_yesterday-processlist.log ]] ;then
           tar zcvf $My_yesterday-processlist.log.tar.gz $My_yesterday-processlist.log
           rm $My_yesterday-processlist.log
           mv $My_yesterday-processlist.log.tar.gz ./processlist/
       fi
       
       echo -e "\n\n\n$My_time" >> $My_file_time-db_connection.log
       My_now_tcp_connections_num=$(netstat -ano |awk '{if($4=="10.117.235.56:3306")print $0}' |wc -l)
       echo "DB connections number : $My_now_tcp_connections_num" >> $My_file_time-db_connection.log
       netstat -ano |awk '{if($4=="10.117.235.56:3306")print $0}' >> $My_file_time-db_connection.log
       if [[ -f $My_yesterday-db_connection.log ]] ;then
           tar zcvf $My_yesterday-db_connection.log.tar.gz $My_yesterday-db_connection.log
           rm $My_yesterday-db_connection.log
           mv $My_yesterday-db_connection.log.tar.gz ./db_connection/
       fi
       
       if [[ -f ./processlist/$My_lastday-processlist.log.tar.gz ]];then
           rm ./processlist/$My_lastday-processlist.tar.gz
       fi
       if [[ -f ./db_connection/$My_lastday-db_connection.log.tar.gz ]];then
           rm ./db_connection/$My_lastday-db_connection.log.tar.gz
       fi
       sleep 10
done
