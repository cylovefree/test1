#!/bin/bash
counter_path="/root/counter"

echo `date` >> sum.out
ls -l $counter_path |grep "2017-06-21" |awk -F " " '{print $9}' >> ./filename.txt

for filename in `cat filename.txt`;do
        for appid in `cat appid.txt`;do
                                grep $appid $counter_path/$filename >> shell.out
        done
done

for counter in $(cat counter.txt);do
  for adname in $(cat adnamelist);do
    case $counter in
      ad_adview|ad_adshow)
          adname_alias=$(cat adname_alias.txt |grep $adname |awk -F "=" '{print $1}')
          num=$(cat shell.out |grep -E "platform\\\\\":\\\\\"$adname_alias" |grep $counter |wc -l)
          echo "$counter,$adname,$adname_alias,$num" >> sum.log
      ;;
      *)
        num=$(cat shell.out |grep -E "\\\\\"$adname\\\\\"" |grep $counter |wc -l)
        echo "$counter,$adname,$num" >> sum.log
      ;;
    esac
  done
done

echo `date` >> sum.out
