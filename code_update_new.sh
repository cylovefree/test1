#!/bin/bash

source /etc/profile
export PASS_FILE_DIR="/data/code_update/4x_new_update/rsync_pass"
export OP_LOCAL_PROJECT_DIR="/data/code_update/4x_new_update/project"

#***********************  module *******************************
## Function update_config:
update_config(){
        ### git拉取代码：
        cd $OP_LOCAL_PROJECT_DIR
        if [[ ! -e "config/game_4x/.git" ]]
            then
                mkdir -p config/game_4x && cd config/game_4x
                git clone -b online git@git.soulgame.com:backend/4x_config.git $OP_LOCAL_PROJECT_DIR/config/game_4x
        else
                cd $OP_LOCAL_PROJECT_DIR/config/game_4x
                git pull
        fi
        My_Git_Status=`git log -1 --pretty=format:"%h|%cd|%s|%an"`
        My_Update_Time=`date "+%Y-%m-%d %H:%M:%S"`
        echo $My_Git_Status"|"$My_Update_Time > git.version
        ###
        rsync -avcrlt --no-o --no-g --exclude ".git" --exclude "*/*/.git/*" --exclude "*/.git/*" --exclude "*/*/.git"  --bwlimit=2048 --progress $OP_LOCAL_PROJECT_DIR/config/game_4x/ gpsupdate@$1::Global_Public_Server/config/game_4x/ --password-file=$PASS_FILE_DIR/rsync_global_server_update.pass
        echo -e "\n\e[0;31;1m     config update OK .\e[0m\n\n\n"
}

## Function update_together:
update_together(){
        ### git拉取代码：
        cd $OP_LOCAL_PROJECT_DIR
        if [[ ! -e "together/.git" ]]
            then
                mkdir -p together && cd together
                git clone -b  cn_4x git@git.soulgame.com:backend/together.git $OP_LOCAL_PROJECT_DIR/together
        else
                cd together
                git pull
        fi
        My_Git_Status=`git log -1 --pretty=format:"%h|%cd|%s|%an"`
        My_Update_Time=`date "+%Y-%m-%d %H:%M:%S"`
        echo $My_Git_Status"|"$My_Update_Time > git.version
        ###
        rsync -avcrlt --no-o --no-g --exclude ".git" --exclude "*/*/.git/*" --exclude "*/.git/*" --exclude "*/*/.git"  --bwlimit=2048 --progress $OP_LOCAL_PROJECT_DIR/together/ gpsupdate@$1::Global_Public_Server/servers_4x/server_$2/together/ --password-file=$PASS_FILE_DIR/rsync_global_server_update.pass
        rsync -avcrlt --no-o --no-g --exclude ".git" --exclude "*/*/.git/*" --exclude "*/.git/*" --exclude "*/*/.git"  --bwlimit=2048 --progress $OP_LOCAL_PROJECT_DIR/together/ gpsupdate@$1::Global_Public_Server/public_api/together/ --password-file=$PASS_FILE_DIR/rsync_global_server_update.pass
        echo -e "\n\e[0;31;1m     together update OK .\e[0m\n\n\n"
}

## Function update_game_4x:
update_game_4x(){
        ### git拉取代码：
        cd $OP_LOCAL_PROJECT_DIR
        if [[ ! -e "game_4x/.git" ]]
            then
                mkdir -p game_4x && cd game_4x
                git clone -b online git@git.soulgame.com:4x/php.git $OP_LOCAL_PROJECT_DIR/game_4x
        else
                cd game_4x
                git pull
        fi
        My_Git_Status=`git log -1 --pretty=format:"%h|%cd|%s|%an"`
        My_Update_Time=`date "+%Y-%m-%d %H:%M:%S"`
        echo $My_Git_Status"|"$My_Update_Time > git.version
        ###
        rsync -avcrlt --no-o --no-g --exclude ".git" --exclude "*/*/.git/*" --exclude "*/.git/*" --exclude "*/*/.git"  --bwlimit=2048 --progress $OP_LOCAL_PROJECT_DIR/game_4x/ gpsupdate@$1::Global_Public_Server/servers_4x/server_$2/game_4x/ --password-file=$PASS_FILE_DIR/rsync_global_server_update.pass
        echo -e "\n\e[0;31;1m     game_4x update OK .\e[0m\n\n\n"
}


## Function update_protobuf:
update_protobuf(){
        ### git拉取代码：
        cd $OP_LOCAL_PROJECT_DIR
        if [[ ! -e "protobuf/.git" ]]
            then
                mkdir -p protobuf && cd protobuf
                git clone -b  master git@git.soulgame.com:4x/common.git $OP_LOCAL_PROJECT_DIR/protobuf
        else
                cd protobuf
                git pull
        fi
        My_Git_Status=`git log -1 --pretty=format:"%h|%cd|%s|%an"`
        My_Update_Time=`date "+%Y-%m-%d %H:%M:%S"`
        echo $My_Git_Status"|"$My_Update_Time > git.version
        ###
        rsync -avcrlt --no-o --no-g --exclude ".git" --exclude "*/*/.git/*" --exclude "*/.git/*" --exclude "*/*/.git"  --bwlimit=2048 --progress $OP_LOCAL_PROJECT_DIR/protobuf/ gpsupdate@$1::Global_Public_Server/servers_4x/protobuf/ --password-file=$PASS_FILE_DIR/rsync_global_server_update.pass
        echo -e "\n\e[0;31;1m     protobuf update OK .\e[0m\n\n\n"
}

### 公共服务api
update_public_api(){
        ### git拉取代码：
        cd $OP_LOCAL_PROJECT_DIR
        if [[ ! -e "public_api/.git" ]]
            then
                mkdir -p public_api && cd public_api
                git clone -b online git@git.soulgame.com:backend/public_api.git $OP_LOCAL_PROJECT_DIR/public_api
        else
                cd public_api
                git pull
        fi
        My_Git_Status=`git log -1 --pretty=format:"%h|%cd|%s|%an"`
        My_Update_Time=`date "+%Y-%m-%d %H:%M:%S"`
        echo $My_Git_Status"|"$My_Update_Time > git.version
        ###
        rsync -avcrlt --no-o --no-g --exclude ".git" --exclude "*/*/.git/*" --exclude "*/.git/*" --exclude "*/*/.git"  --bwlimit=2048 --progress $OP_LOCAL_PROJECT_DIR/public_api/ gpsupdate@$1::Global_Public_Server/public_api/public_api/ --password-file=$PASS_FILE_DIR/rsync_global_server_update.pass
        echo -e "\n\e[0;31;1m     public_api update OK .\e[0m\n\n\n"
}
### 公共服务config
update_public_config(){
        ### git拉取代码：
        cd $OP_LOCAL_PROJECT_DIR
        if [[ ! -e "public_config/.git" ]]
            then
                mkdir -p public_config && cd public_config
                git clone -b online git@git.soulgame.com:backend/public_api_config.git $OP_LOCAL_PROJECT_DIR/public_config
        else
                cd public_config
                git pull
        fi
        My_Git_Status=`git log -1 --pretty=format:"%h|%cd|%s|%an"`
        My_Update_Time=`date "+%Y-%m-%d %H:%M:%S"`
        echo $My_Git_Status"|"$My_Update_Time > git.version
        ###
        rsync -avcrlt --no-o --no-g --exclude ".git" --exclude "*/*/.git/*" --exclude "*/.git/*" --exclude "*/*/.git"  --bwlimit=2048 --progress $OP_LOCAL_PROJECT_DIR/public_config/ gpsupdate@$1::Global_Public_Server/config/public_api/ --password-file=$PASS_FILE_DIR/rsync_global_server_update.pass
        echo -e "\n\e[0;31;1m     public_config update OK .\e[0m\n\n\n"
}

## Function update_4xdb:
update_4xdb(){
        ### git拉取代码：
        cd $OP_LOCAL_PROJECT_DIR
        if [[ ! -e "4xdb/.git" ]]
            then
                mkdir -p 4xdb && cd 4xdb
                git clone -b 4x_online git@git.soulgame.com:4x/db.git $OP_LOCAL_PROJECT_DIR/4xdb
        else
                cd 4xdb
                git pull
        fi
        My_Git_Status=`git log -1 --pretty=format:"%h|%cd|%s|%an"`
        My_Update_Time=`date "+%Y-%m-%d %H:%M:%S"`
        echo $My_Git_Status"|"$My_Update_Time > git.version
        ###
        rsync -avcrlt --no-o --no-g --exclude ".git" --exclude "*/*/.git/*" --exclude "*/.git/*" --exclude "*/*/.git"  --bwlimit=2048 --progress $OP_LOCAL_PROJECT_DIR/4xdb/ gpsupdate@$1::Global_Public_Server/servers_4x/server_$2/db/ --password-file=$PASS_FILE_DIR/rsync_global_server_update.pass
        echo -e "\n\e[0;31;1m     4xdb update OK .\e[0m\n\n\n"
}

DISTROS=$(whiptail --title "Test Checklist Dialog" --checklist \
"Choose update server" 20 45 3 \
"0001" "4x一区" OFF \
"0002" "4x二区" OFF 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
#    echo "Your favorite distros are:" $DISTROS
    echo $DISTROS > list.log
else
    echo "You chose Cancel."
fi

MODULE=$(whiptail --title "Test Checklist Dialog" --checklist \
"Choose update module" 20 160 8 \
"1" "config" OFF \
"2" "together" OFF \
"3" "game_4x" OFF \
"4" "protobuf" OFF \
"5" "4x_db" OFF \
"6" "public_api" OFF \
"7" "public_api_conf" OFF 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
#    echo "Your favorite distros are:" $MOUDLE
    echo $MODULE > list2.log
else
    echo "You chose Cancel."
fi


#***********************  main function ***********************
### 判断是否选择了空选项，该脚本不允许空选
if [[ ! $(cat list.log) ]];then
    echo "You should choose the ip address!"
    exit
fi

if [[ ! $(cat list2.log) ]];then
    echo "You should choose the update module!"
    exit
fi

server_number_total=$(cat list.log |awk '{print NF}')
server_module_total=$(cat list2.log |awk '{print NF}')

for server_number_single in $(seq 1 $server_number_total);do
    ### 获取选择更新的区／服号
    server_number=$(cat list.log |sed "s/\"//g" |awk -v server_number_single="$server_number_single" "{print \$$server_number_single}")
    ### 获取更新的区／服号对应的IP地址
    for server_number_ip in $(cat server_config.txt |grep -v -E "^#" |grep $server_number |awk '{print $1}');do
        for module_number_single in $(seq 1 $server_module_total);do
            ### 获取选择更新的模块
            module_number=$(cat list2.log |sed "s/\"//g" |awk -v module_number_single="$module_number_single" "{print \$$module_number_single}")
            case $module_number in
                1)
                    update_config $server_number_ip $server_number
                    ;;
                2)
                    update_together $server_number_ip $server_number
                    ;;
                3)
                    update_game_4x $server_number_ip $server_number
                    ;;
                4)
                    update_protobuf $server_number_ip $server_number
                    ;;
                5)
                    update_4xdb $server_number_ip $server_number
                    ;;
                6)
                    update_public_api $server_number_ip $server_number
                    ;;
                7)
                    update_public_config $server_number_ip $server_number
                    ;;
            esac
        done
    done
done
