#!/usr/bin/env bash

if [ $# -ne 2 ] ; then
    echo "usage: reset_network.sh <chaincode_name> <programming_language>"
    exit 2
fi

CHAINCODE_NAME="$1"

PROGRAMMING_LANGUAGE="$2"

if [ ! -d  chaincodes/$CHAINCODE_NAME ] ; then
    echo "ERROR: Invalid chaincode folder name"
    exit 0
fi

SUFFIX=""

if [ "$2" == "javascript" ] ; then
    SUFFIX="/node"
fi

set -x

cd ../fabric-samples/test-network

./network.sh down
./network.sh up createChannel -ca #-s couchdb

# cd addOrg3

# ./addOrg3.sh up -c mychannel #-s couchdb

# cd ..

./network.sh deployCC -ccn $CHAINCODE_NAME -ccp ../../caliper-workspace/chaincodes/$CHAINCODE_NAME$SUFFIX -ccl $PROGRAMMING_LANGUAGE

set +x
