#!/bin/bash

BUILD_TIME=$(($CURRENT_BUILD / 1000))

#ssh $CONNECTION "mysqldump -u root -proot shopware > $MYSQLDUMP_PATH/$(ssh $CONNECTION date -d  @$BUILD_TIME +$FORMAT).sql"
ssh $CONNECTION "cp -a $DEPLOYMENT_PATH/$(ssh $CONNECTION readlink $SYMLINK_PATH) $DEPLOYMENT_PATH/$(ssh $CONNECTION date -d  @$BUILD_TIME +$FORMAT)"