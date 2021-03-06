#!/bin/bash

echo "Cloning 389-ds repository..."
git clone --depth 1 https://github.com/jtgasper3/docker-images.git

echo "Copying base LDIF files to prepare LDAP server..."
cp ./ci/ldap/ds-setup.inf docker-images/389-ds
cp ./ci/ldap/users.ldif docker-images/389-ds

echo "Building LDAP docker image..."
docker rmi apereocastests/ldap --force
docker build --tag="apereocastests/ldap"  ./docker-images/389-ds

rm -Rf docker-images
# rm -f ./ci/ldap/users.ldif

echo "Running LDAP docker image"
docker run -d -p 10389:389 --name="ldap-server" apereocastests/ldap
docker ps


