This file is a tutorial on how to set up the Hyperledger Fabric test network and use it with the benchmarking framework Hyperledger Caliper. Moreover, the repository contains predefined chaincodes and scripts that facilitate the benchmarking process.

# Set up test network

If you do not have a Fabric network set up already, you may want to use the [Hyperledger Fabric test network](https://hyperledger-fabric.readthedocs.io/en/latest/test_network.html). The steps related to the test network setup can be executed before cloning this repository.

### Install prerequisites
To be able to run a Hyperledger Fabric network on your machine, the installation of certain [prerequisites](https://hyperledger-fabric.readthedocs.io/en/release-2.2/prereqs.html) is required.

### Execute `curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.2.2 1.4.9`
This command clones the fabric-samples repository, and installs the required binaries and Docker images.
You should clone the fabric-samples repository in the same location as this repository in order for the scripts to work. Hence, the folders named caliper-workspace and fabric-samples should be in the same location.

```    
│
└───caliper-workspace
│       
│   
└───fabric-samples
│   │
│   └───test-network
│   │
│   └───...
```

You should now be able to go to the directory of the test network (`cd fabric-samples/test-network`).

# Hyperledger Caliper
You may also want to use the official [documentation](https://hyperledger.github.io/caliper/v0.4.2/fabric-tutorial/tutorials-fabric-existing/) of Caliper to set up the benchmarking manually. In this case, this repository is not needed. However, using version v0.5.0 of Caliper instead of v0.4.2 is recommended to avoid certain errors.

Before using Caliper for the first time, execute the following two commands in the project directory of this repository (caliper-workspace):

### `npm install --only=prod @hyperledger/caliper-cli@0.5.0`

### `npx caliper bind --caliper-bind-sut fabric:2.2`

-----

In the project directory (caliper-workspace), you can now execute the following command to set up the Fabric network. This command executes a script that resets the network and installs the desired chaincode.

### Adapt network configuration
You can adapt parameters such as block size by editing the <strong>fabric-samples/test-network/configtx/configtx.yaml</strong> file.

### `./reset_network.sh <chaincode_name> <programming_language>`
The chaincode must be contained in the [chaincodes](https://github.com/ninori9/caliper-workspace/tree/main/chaincodes) folder. The programming language of the defined chaincodes is either go or javascript.

### Edit [networkConfig.yaml](https://github.com/ninori9/caliper-workspace/blob/main/networks/networkConfig.yaml)
Edit the <strong>clientPrivateKey path</strong> parameter so that it matches the private key file of the user in the test-network. The name of this file changes every time the network is reset. If you have deployed a new chaincode, make sure a <strong>channels contracts id</strong> entry exists for the chaincode. You might also want to ensure that the remaining information is filled out correctly.

### Edit the benchmark configuration and workflow
You can find predefined workloads for the different chaincodes in the [benchmarks](https://github.com/ninori9/caliper-workspace/tree/main/benchmarks) folder. Each benchmark can be configured by editing the <strong>config.yaml</strong> file in the respective benchmarks folders of the chaincodes. Here a user can change variables such as the send rate or the number of Caliper workers.

The directory name of the config.yaml file modified should match the chaincode installed on the network.

The workloads (.js files in the folders) might also be modified depending on the individual use case.

### `./caliper_run.sh <chaincode_name>`
This command initiates the benchmarking run. Based on the configuration, transactions are submitted to the network.

-----

# Add chaincodes and workloads
You can easily add chaincodes and workloads by copying the chaincode folders in the [chaincodes](https://github.com/ninori9/caliper-workspace/tree/main/chaincodes) directory and the workload files for the chaincode in the [benchmarks](https://github.com/ninori9/caliper-workspace/tree/main/benchmarks) directory.
