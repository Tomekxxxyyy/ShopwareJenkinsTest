#!/bin/bash

BUILD_TIME=$(($CURRENT_BUILD / 1000))

#ssh $CONNECTION "ln -sfn $/releases/$(ssh $CONNECTION date -d  @$BUILD_TIME +$FORMAT) web"