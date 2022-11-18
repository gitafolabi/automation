#!/usr/bin/bash

USER=votingapp
PASSWORD=Password@Vagrant
echo -n ${USER} | base64
echo -n ${PASSWORD} | base64