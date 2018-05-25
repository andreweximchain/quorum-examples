#!/bin/bash

set -eu -o pipefail

# install build deps
add-apt-repository ppa:ethereum/ethereum
apt-get update
apt-get install -y build-essential unzip libdb-dev libsodium-dev zlib1g-dev libtinfo-dev cmake sysvbanner wrk libboost-all-dev

# install constellation
wget -O ubuntu1604.zip -q https://github.com/jpmorganchase/constellation/releases/download/v0.0.1-alpha/ubuntu1604.zip
unzip ubuntu1604.zip
cp ubuntu1604/constellation-node /usr/local/bin && chmod 0755 /usr/local/bin/constellation-node
cp ubuntu1604/constellation-enclave-keygen /usr/local/bin && chmod 0755 /usr/local/bin/constellation-enclave-keygen
rm -rf ubuntu1604.zip ubuntu1604

# VER=v0.4.2
# DIR_NAME=solidity_0.4.2

# VER=v0.4.5
# DIR_NAME=solidity-0.4.5
# wget https://github.com/ethereum/solidity/releases/download/$VER/$DIR_NAME.tar.gz
# wget https://github.com/ethereum/solidity/archive/v0.4.5.tar.gz
# tar -xzf $VER.tar.gz
# cd $DIR_NAME
# git clone https://github.com/ethereum/solidity
# cd solidity
# git checkout b318366e
# git submodule update --init --recursive
# scripts/install_deps.sh
# mkdir build
# cd build
# cmake .. && make
# # wget https://github.com/ethereum/solidity/releases/download/v0.4.19/solc-static-linux
# sudo mv solc/solc /usr/local/bin/
# sudo chmod 0755 /usr/local/bin/solc
# cd ../..
# && rm -rf $DIR_NAME.tar.gz $DIR_NAME

# install golang
GOREL=go1.7.3.linux-amd64.tar.gz
wget -q https://storage.googleapis.com/golang/$GOREL
tar xfz $GOREL
mv go /usr/local/go
rm -f $GOREL
PATH=$PATH:/usr/local/go/bin
echo 'PATH=$PATH:/usr/local/go/bin' >> /home/ubuntu/.bashrc

# make/install quorum
RELEASE="v1.2.1-modified"
git clone https://github.com/andreweximchain/quorum.git
pushd quorum >/dev/null
git checkout $RELEASE
make all
cp build/bin/geth /usr/local/bin
cp build/bin/bootnode /usr/local/bin
popd >/dev/null

# copy examples
cp -r /vagrant/examples /home/vagrant/quorum-examples
chown -R ubuntu:ubuntu ~/quorum /home/vagrant/quorum-examples

# done!
banner "Quorum"
echo
echo 'The Quorum vagrant instance has been provisioned. Examples are available in ~/quorum-examples inside the instance.'
echo "Use 'vagrant ssh' to open a terminal, 'vagrant suspend' to stop the instance, and 'vagrant destroy' to remove it."
