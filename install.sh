#!/usr/bin/env bash

mkdir -p ~/.aws/cli
pushd ~/.aws
git clone https://github.com/thimslugga/awscli-aliases.git
cp -a awscli-aliases/alias ~/.aws/cli/alias
popd
