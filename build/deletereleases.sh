#!/bin/bash

BUILD_TIME=$(($CURRENT_BUILD / 1000))

$(ssh $CONNECTION "ls $DEPLOYMENT_PATH | head -n -5 | xargs rm -R)"

