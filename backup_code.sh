#!/bin/bash

### just backup for the code of the game 

source /etc/profile 

if [[ ! -d /data/backup ]]; then
  ### create a dir for backup
  mkdir -p /data/backup
fi  

### some conf files

game_file_paths="./game_file_path.txt"

remote_ips="./remote_ip.txt"

### Main

#### local_ip

for game_file_path in `cat $game_file_paths`;do
  if [[ ! -d $game_file_path ]]; then
    echo "There is no game dir!"
    echo "Please check the $game_file_paths !"
    break
  fi
  echo -e `date` >> ./backup.logs
  echo "backup the $game_file_path..." >> ./backup.logs
  cp -R $game_file_path /data/backup/$game_file_path-`date +%Y-%m-%d`
  if [[ -d /data/backup/$game_file_path ]]; then
    echo "$game_file_path backup is finished" >> ./backup.logs
  else
    echo "$game_file_path backup filed" >> ./backup.logs
  fi
done

#### remote_ip
for remote_ip in `cat remote_ips`;do
  for game_file_path in `cat $game_file_paths`;do
    backup_code="cp -R $game_file_path /data/backup/$game_file_path-'date +%Y-%m-%d'"
    ssh -t ubuntu@$remote_ip "$backup_code"
    echo "$remote_ip $game_file_path backup is finished, but you should check the dir" >> ./backup.logs
  done
done

echo -e "end \n" >> ./backup.logs
