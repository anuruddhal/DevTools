#!/bin/bash

version=0.970.0-alpha1-SNAPSHOT
packVersion=0.970.0-alpha1-SNAPSHOT
pushd /Users/anuruddha/Repos/ballerinax/ballerina
git checkout composer/modules/web/package-lock.json
git pull --rebase upstream master
mvn clean install -Dmaven.test.skip=true
rm -r /Users/anuruddha/Desktop/workspace/ballerina-tools-${packVersion}
rm /Users/anuruddha/Desktop/workspace/ballerina-tools-${packVersion}.zip
cp distribution/zip/ballerina-tools/target/ballerina-tools-${packVersion}.zip /Users/anuruddha/Desktop/workspace/
popd
pushd /Users/anuruddha/Desktop/workspace/
unzip -q ballerina-tools-${packVersion}.zip
popd
pushd /Users/anuruddha/Repos/ballerinax/docker
mvn clean install
popd
pushd /Users/anuruddha/Repos/ballerinax/kubernetes
mvn clean install
popd
pushd /Users/anuruddha/Desktop/workspace/ballerina-tools-${packVersion}/bre/lib
ln -s /Users/anuruddha/Repos/ballerinax/kubernetes/target/kubernetes-extension-${version}.jar .
ln -s /Users/anuruddha/Repos/ballerinax/docker/target/docker-extension-${version}.jar .
popd
echo "Local bdk configured ..."
rm /Users/anuruddha/Repos/ballerinax/docker/base/docker/ballerina-${packVersion}.zip
rm -r /Users/anuruddha/Repos/ballerinax/docker/base/docker/ballerina-${packVersion}
cp /Users/anuruddha/Repos/ballerinax/ballerina/distribution/zip/ballerina/target/ballerina-${packVersion}.zip /Users/anuruddha/Repos/ballerinax/docker/base/docker
pushd /Users/anuruddha/Repos/ballerinax/docker/base/docker
unzip -q ballerina-${packVersion}.zip
cp /Users/anuruddha/Repos/ballerinax/kubernetes/target/kubernetes-extension-${version}.jar ./ballerina-${packVersion}/bre/lib/
cp /Users/anuruddha/Repos/ballerinax/docker/target/docker-extension-${version}.jar ./ballerina-${packVersion}/bre/lib/
rm ballerina-${packVersion}.zip
zip -r ballerina-${packVersion}.zip ballerina-${packVersion} -x "*.DS_Store"
docker build --no-cache=true --squash --build-arg BALLERINA_DIST=ballerina-${packVersion}.zip -t ballerina/ballerina:${version} .
#docker push ballerina/ballerina:${version}

