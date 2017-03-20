#!/bin/bash

cat $1 | redis-cli -h localhost -p 6379
