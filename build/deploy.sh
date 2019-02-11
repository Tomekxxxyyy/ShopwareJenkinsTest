#!/bin/bash

BUILD_TIME=$(($CURRENT_BUILD / 1000))

tar -czvf $BUILD_TIME.tar.gz ./
scp $BUILD_TIME.tar.gz $CONNECTION:$DEPLOYMENT_PATH/$(ssh $CONNECTION date -d  @$BUILD_TIME +$FORMAT)
rm -R $BUILD_TIME.tar.gz