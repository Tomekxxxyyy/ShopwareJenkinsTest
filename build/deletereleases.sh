#!/bin/bash

BUILD_TIME=$(($CURRENT_BUILD / 1000))

ssh $CONNECTION "ln -sfn ls | head -n -5 | xargs rm -R"

