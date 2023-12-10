#!/usr/bin/env bash

if [ $# -ne 1 ] ; then
    echo "usage: caliper_run.sh <chaincode_name>" 
    exit 2
fi

CHAINCODE_NAME="$1"

if [ ! -d  ./benchmarks/$CHAINCODE_NAME ] ; then
    echo "ERROR: Invalid chaincode folder name"
    exit 0
fi

set -x

cd benchmarks/$CHAINCODE_NAME

npm install

cd ../../

npx caliper launch manager --caliper-workspace ./ --caliper-networkconfig networks/networkConfig.yaml --caliper-benchconfig benchmarks/$CHAINCODE_NAME/config.yaml --caliper-flow-only-test --caliper-fabric-gateway-enabled --caliper-fabric-timeout-invokeorquery 110

set +x
