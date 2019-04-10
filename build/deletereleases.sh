#!/bin/bash

BUILD_TIME=$(($CURRENT_BUILD / 1000))

ssh $CONNECTION "rm -R $DEPLOYMENT_PATH $(ls $DEPLOYMENT_PATH | head -n -5)"

