#!/bin/bash
set -ex
sudo apt-key update
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y \
    wget \
    build-essential \
    git \
    curl \
    openjdk-7-jre \
    vim-nox python-pip

# Install python packages
sudo pip install supervisor bernhard click flask tabulate redis httpie

# Install redis
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
sudo cp src/redis-cli src/redis-server /usr/local/bin
cd -
cat >> ~/.bashrc <<EOF
alias vi=vim
cd ~/riemann-workshop
EOF
cat >> ~/.vimrc <<EOF
set tabstop=2
set shiftwidth=2
set ai
set expandtab
EOF

# Download and extract riemann
wget https://aphyr.com/riemann/riemann-0.2.11.tar.bz2
tar xvfj riemann-0.2.11.tar.bz2

# Init workshop
git clone https://github.com/bergundy/riemann-workshop
mv riemann-0.2.11/lib/riemann.jar riemann-workshop/resources
sudo wget -O /usr/local/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
sudo chmod a+x /usr/local/bin/lein
cd riemann-workshop
lein test
cd -
