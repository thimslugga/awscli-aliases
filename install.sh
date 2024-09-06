#!/usr/bin/env bash

# Install the dependencies

mkdir -p ~/.aws/cli
#echo '[toplevel]' > ~/.aws/cli/alias

pushd ~/.aws
git clone https://github.com/awslabs/awscli-aliases.git
cp awscli-aliases/alias ~/.aws/cli/alias
popd
