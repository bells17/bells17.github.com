#!/bin/bash
set -e
rm -rf public || exit 0;

pwd
ls -la

echo -e "Host github.com\n\tStrictHostKeyChecking no\nIdentityFile ~/.ssh/deploy.key\n" >> ~/.ssh/config
# openssl aes-256-cbc -k "$secret" -in deploy.enc -d -a -out deploy.key
# cp deploy.key ~/.ssh/
echo -e "$deploy_key" >> ~/.ssh/deploy.key
chmod 600 ~/.ssh/deploy.key

# sshpass -o "" ssh 
git clone -b master https://github.com/bells17/bells17.github.io.git public

wget https://github.com/spf13/hugo/releases/download/v0.15/hugo_0.15_linux_amd64.tar.gz
tar zxvf hugo_0.15_linux_amd64.tar.gz
hugo_0.15_linux_amd64/hugo_0.15_linux_amd64

cd public

git config --global user.email "example@example.com"
git config --global user.name "Travis-CI"

git add -A
git commit -m "Generate Travis JOB $TRAVIS_JOB_NUMBER
https://travis-ci.org/bells17/bells17.github.io/builds/$TRAVIS_BUILD_ID"

git push origin master
rm ~/.ssh/deploy.key
