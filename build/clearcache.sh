#!/bin/bash

BUILD_TIME=$(($CURRENT_BUILD / 1000))

ssh $CONNECTION "$DEPLOYMENT_PATH/$(ssh $CONNECTION date -d  @$BUILD_TIME +$FORMAT)/var/cache/clear_cache.sh"