#!/bin/bash

BUILD_TIME=$(($CURRENT_BUILD / 1000))

ssh $CONNECTION "rm -R $(ls ssh $CONNECTION $DEPLOYMENT_PATH | head -n -5)"

