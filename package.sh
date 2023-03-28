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

#tar --exclude=./ui/node_modules --exclude=.idea --exclude=./ui/src --exclude=./ui/public --exclude=./ui/*config* \
#--exclude=./ui/*config*  --exclude=__pycache__ --exclude=chat.tar.gz  --exclude=.idea  \
#--exclude=chat_app_v2.0.0.tar.gz --exclude=chat_app_v3.0.0.tar.gz \
#--exclude=./ui/jest.setup.ts  --exclude=./ui/package.json  --exclude=./ui/yarn.lock \
#--exclude=.gitigore --exclude=.git \
#-czvf chat_app_v1.0.0.tar.gz .
#scp -i ~/Documents/keys/jarlyn.pem chat_app_v1.0.0.tar.gz ec2-user@52.91.185.210:/home/ec2-user/chat_app/v1.0.0/
