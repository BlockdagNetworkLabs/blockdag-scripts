#!/bin/bash

pushd ../../blockdag 
make
popd

rm -rf ./bin/bdag/*
cp -rf ../../blockdag/build/bin/bdag ./bin/bdag
