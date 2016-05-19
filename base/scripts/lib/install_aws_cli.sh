#!/bin/bash
set -e
curl https://s3.amazonaws.com/aws-cli/awscli-bundle.zip > awscli-bundle.zip
unzip awscli-bundle.zip
./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
mkdir -p /root/.aws
cat <<"EOF" > /root/.aws/config
[default]
output = text
region = us-east-1
EOF
