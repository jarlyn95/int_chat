#!/bin/bash

cd ui
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
source ~/.bashrc
nvm use v16
echo $NVM_BIN
node --version
yarn install
yarn build

# shellcheck disable=SC2103
cd ..

tar --exclude=./ui/node_modules --exclude=.idea --exclude=./ui/src --exclude=./ui/public --exclude=./ui/*config* \
--exclude=./ui/*config*  --exclude=__pycache__ --exclude=chat.tar.gz  --exclude=.idea  \
--exclude=./ui/jest.setup.ts  --exclude=./ui/package.json  --exclude=./ui/yarn.lock \
--exclude=.gitigore --exclude=.git \
-czvf chat.tar.gz .
scp -i ~/Documents/keys/jarlyn.pem chat.tar.gz ec2-user@100.25.222.164:/home/ec2-user/
