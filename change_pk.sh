#!/bin/bash

# Define an array of public addresses
addresses=(
"43c1bdb7d3e0533e4f100d1e6f03c5e6112dbaa822613c49bad2d60b13f89ccc"
"4d991c124f9faaa179796eb47306f1a5407eb3c7b092876dfcec1ffeac947de8"
"6fc1573eb14ea4a3d7104d8abdb83c563e5204989dcc020fb213823c41f3a914"
"a44c301b47464b41452eba3eb0e098026cf532bba76c88b1ea9f37d0f551a692"
"8fb6c85db5dc35e9ea8a2020c8cddb0c4a80cfdf5509f7ad2b346bd4dff16ed4"
"79a7be619815cb2fc62d63fd4e8bd2cd0756a8205411816698ce763046a68732"
"5c1357f1175d73de8b7a97f1032eb5fa664cfa41c9f5971a5059a4b43431f742"
"9b2ddf5903db155e864021a4e4073a331ace21604755071e49161ba7f27e1f5a"
"7a175ab2efbac73472bd0a28477b819a661507af0cc7a3f1b608f9f50d950d53"
)

pushd /data/finl_blockdag/test/blockdag/bin/qx
# Iterate over the array and print each address
for address in "${addresses[@]}"; do
pk_addr=$(./qx ec-to-public $address | ./qx ec-to-pkaddr -v=testnet)
echo "public addresses : "
echo $pk_addr
echo $pk_addr >> all_pk.txt
sleep 2
done
popd