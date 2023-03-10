#!/bin/bash

tar --exclude=./ui/node_modules --exclude=.idea --exclude=./ui/src --exclude=./ui/public --exclude=./ui/*config* \
--exclude=./ui/*config*  --exclude=__pycache__ --exclude=chat.tar.gz  --exclude=.idea  \
--exclude=./ui/jest.setup.ts  --exclude=./ui/package.json  --exclude=./ui/yarn.lock \
--exclude=.gitigore --exclude=.git \
-czvf chat.tar.gz .
scp -i ~/Documents/keys/jarlyn.pem chat.tar.gz ec2-user@100.25.222.164:/home/ec2-user/
