#!/bin/bash

BUILD_TIME=$(($CURRENT_BUILD / 1000))

tar -czvf $BUILD_TIME.tar.gz --exclude='.git' ./
scp $BUILD_TIME.tar.gz $CONNECTION:$DEPLOYMENT_PATH/$(ssh $CONNECTION date -d  @$BUILD_TIME +$FORMAT)
ssh $CONNECTION "tar -xzvf $DEPLOYMENT_PATH/$(ssh $CONNECTION date -d  @$BUILD_TIME +$FORMAT)/$BUILD_TIME.tar.gz -C $DEPLOYMENT_PATH/$(ssh $CONNECTION date -d  @$BUILD_TIME +$FORMAT)"
ssh $CONNECTION "rm -R $DEPLOYMENT_PATH/$(ssh $CONNECTION date -d  @$BUILD_TIME +$FORMAT)/$BUILD_TIME.tar.gz"
rm -R $BUILD_TIME.tar.gz