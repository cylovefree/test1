#!/bin/bash

counter_path="../2017.06/counter3"

ls -l $counter_path |grep "2017-06-12" |awk -F " " '{print $9}' >> ./filename.txt

for filename in `cat filename.txt`;do
        for counter_id in `cat ./counter_id.txt`;do
                cat $counter_path/$filename |grep "828V0279LzXV4T84476N" |grep "mobvista" |grep $counter_id |wc -l |while read num;do
                        echo "$filename appid:828V0279LzXV4T84476N flatform:mobvista counter_id:$counter_id num:$num" >> ./sum3.txt
                done
        done
done

for counter_id in `cat ./counter_id.txt`;do
        counter1_num=`cat sum3.txt |grep $counter_id |awk -F " " '{print $5}' |awk -F ":" '{print $2}' |awk '{a += $0}END{print a}'`
        echo "$counter_id  :  $counter1_num" >> ./sumall3.txt
done
