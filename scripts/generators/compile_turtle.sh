#!/bin/bash

cd $1

clj -M:compile-ttl $2 $3

cd -  &> /dev/null
