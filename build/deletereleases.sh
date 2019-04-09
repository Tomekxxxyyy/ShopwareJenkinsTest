#!/bin/bash

BUILD_TIME=$(($CURRENT_BUILD / 1000))

ssh $CONNECTION "ls $DEPLOYMENT_PATH/$(ssh $CONNECTION date -d  @$BUILD_TIME +$FORMAT) | head -n -5 | xargs rm -R"

