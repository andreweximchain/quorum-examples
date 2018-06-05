# Quorum Examples

This repository contains setup examples for Quorum.

Current examples include:
* [7nodes](https://github.com/jpmorganchase/quorum-examples/tree/master/examples/7nodes): Starts up a fully-functioning Quorum environment consisting of 7 independent nodes with a mix of block makers, voters, and unprivileged nodes. From this example one can test consensus, privacy, and all the expected functionality of an Ethereum platform.
* [permissions](https://github.com/jpmorganchase/quorum-examples/tree/master/examples/permissions): Focuses on how to add, remove, and update the list of nodes permitted to participate in the network.

The easiest way to get started with running the examples is to use the vagrant environment (see below).

**Important note**: Any account/encryption keys contained in this repository are for
demonstration and testing purposes only. Before running a real environment, you should
generate new ones using Geth's `account` tool and `constellation-enclave-keygen`.

## Vagrant Usage

This is a complete Vagrant environment containing Quorum, Constellation, and the
Quorum examples.

### Requirements

  1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
  1. Install [Vagrant](https://www.vagrantup.com/downloads.html)

(If you are behind a proxy server, please see https://github.com/jpmorganchase/quorum/issues/23)

### Running

```sh
git clone https://github.com/andreweximchain/quorum-examples
cd quorum-examples
vagrant up
# (should take 5 or so minutes)
vagrant ssh
```

(*macOS note*: If you get an error saying that the ubuntu/xenial64 image doesn't
exist, please run `sudo rm -r /opt/vagrant/embedded/bin/curl`. This is usually due to
issues with the version of curl bundled with Vagrant.)

Once in the VM environment, `cd quorum-examples` then simply follow the
instructions for the demo you'd like to run.

To shut down the Vagrant instance, run `vagrant suspend`. To delete it, run
`vagrant destroy`. To start from scratch, run `vagrant up` after destroying the
instance.

### Changes(IMPORTANT)
For this repo changes have been mainly made in the 7nodes section to test if the gasPricing activation in the repo http://github.com/andreweximchain/quorum has worked. Further testing still need to be conducted but once vagrant is up and running, you should vagrant ssh in to the vagrant instance and cd in to the 7nodes directory inside quorum-examples. Then simply run 
```
sudo ./init.sh
sudo ./start.sh
sudo ./sendTransaction.sh
```
start.sh should also initiate a transaction to start, but sometimes it fails because the nodes haven't discovered each other yet. So, running sendTransaction.sh again should fix any issues there. 

To check if the transaction went through you can ipc attach to any of the quorum instances running. 
```
sudo geth attach qdata/dd2/geth.ipc 

ONCE IN THE GETH JAVASCRIPT ENVIROMENT

>eth.getTransaction("0x95bd18733eb396f6dba4e7e820ea8e298c78e02cb86d505fad7a187e15eb2404")
>{
  blockHash: "0xad4635e5baad38a125bdae3d415a5348ef9ec13c33be160724b0c525aa221c95",
  blockNumber: 220,
  from: "0xed9d02e382b34818e88b88a309c7fe71e65f419d",
  gas: 90000,
  gasPrice: 20000000000,
  hash: "0x95bd18733eb396f6dba4e7e820ea8e298c78e02cb86d505fad7a187e15eb2404",
  input: "0x",
  nonce: 2,
  r: "0xa9be660d125064908088670118fec41cd667e7d27bd25f52511fbd5647700783",
  s: "0x33f0439c750f2118135e85c33c8a50a60c08b8397bcdfeee08e6b33a64d2e972",
  to: "0xca843569e3427144cead5e4d5999a3d0ccf92b8e",
  transactionIndex: 4,
  v: "0x1b",
  value: 1000000000000000
}
```
Any changes you want to make regarding the script running in the JSRE of quorum you can do so in script1.js.

