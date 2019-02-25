#!/bin/bash

BUILD_TIME=$(($CURRENT_BUILD / 1000))

ssh $CONNECTION "cd $SYMLINK_PATH; ln -sfn ../releases/$(ssh $CONNECTION date -d  @$BUILD_TIME +$FORMAT) web"