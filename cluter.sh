#!/usr/bin/env bash

echo $NODE_INFO >> /opt/zookeeper/conf/zoo.cfg 
echo $MYID > /tmp/zookeeper/myid

