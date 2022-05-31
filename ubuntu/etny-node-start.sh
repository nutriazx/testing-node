#!/bin/bash
. /home/vagrant/etny/node/config

cd /home/vagrant/etny/node/go-ipfs

IP=`getent hosts ns3195815.ip-54-38-37.eu | awk '{print $1}'`

until ./ipfs swarm connect /ip4/$IP/tcp/4001/ipfs/12D3KooWEuThMa6CNbjc6w5yA7xPkEGD8YjhL6Ayh9SP92gY9hoG
do
  nohup ./ipfs daemon &
  IP=`getent hosts ns3195815.ip-54-38-37.eu | awk '{print $1}'`
  sleep 5
done

./ipfs bootstrap add /ip4/$IP/tcp/4001/ipfs/12D3KooWEuThMa6CNbjc6w5yA7xPkEGD8YjhL6Ayh9SP92gY9hoG

cd /home/vagrant/etny/node/etny-repo/node/
git pull

/home/vagrant/etny/node/etny-repo/node/etny-node.py -a $ADDRESS -k $PRIVATE_KEY -r $RESULT_ADDRESS -j $RESULT_PRIVATE_KEY
